<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crewdig.com - Invite New Members</title>

     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>

<cfparam name="url.cid" default="0">
<cfparam name="deletedUsername" default="">
<cfparam name="form.memberToDelete" default=0>
<cfparam name="url.delUser" default=0>
<cfparam name="url.delInvited" default=0>

        <script>
            function setFormInputs(memberId, username) {
                // Get the form input elements by their IDs
                const usernameInput = document.getElementById('usernameToDelete');
                const memberIdInput = document.getElementById('memberToDelete');

                // Set the values of the input elements
                usernameInput.value = username;
                memberIdInput.value = memberId;
            }

            function setDelInvitedInputs(name, email) {
                // Get the form input elements by their IDs
                const nameInput = document.getElementById('nameToDelete');
                const emailInput = document.getElementById('emailToDelete');

                // Set the values of the input elements
                nameInput.value = name;
                emailInput.value = email;
            }            
        </script>

<body>

    <!---Nav Bar Menu--->

    <cfinclude  template="navBarMenu.cfm">
    
    <!---End Nav Bar Menu---> 

    <cfif not IsDefined("session.loggedIn")>
        <cflocation url="index.cfm?trylog=1" addtoken="false">
    </cfif>    
    <cfif url.cid eq 0>
        <cflocation url="crewPanel.cfm" addtoken="false">
    </cfif> 

        <cfquery name="crew">
            SELECT id, uid, crew_name, crew_desc, private, crew_pic, category, crew_password 
            FROM c_crews 
            WHERE   id = #url.cid# 
        </cfquery>

        <cfquery name="members"> 
            SELECT  m.id, m.cid, m.uid, m.is_creator, m.date_added, u.username, u.email, u.phone, u.first_name, u.last_name
            FROM    c_members AS m INNER JOIN
                        c_users AS u ON m.uid = u.id
            WHERE     m.cid = #url.cid#
        </cfquery>

        <cfquery name="invitedPeople"> 
            SELECT  id, cid, name, email, phone, date_invited
            FROM    c_invited
            WHERE     cid = #url.cid#
        </cfquery>

    
<!---     <cfif form.memberToDelete neq 0> 
        <cfset myInstance = createObject("component",  "components.crewMembers")>
        <cfset delResult = myInstance.deleteMember(form.memberToDelete, "#form.usernameToDelete#")>
        <cflocation url="viewMembers.cfm?cid=#url.cid#&delResult=#delResult#" addtoken="false">
    </cfif>--->

    <div class="container-fluid bg-info" style="--bs-bg-opacity: .3;">
        <div class="px-4 pt-2 my-2 text-center border-bottom">
            <div class="col-12 text-center">
                <h4 class="display-6">                  
                        Members of <cfoutput>#session.username#'s <b>#crew.crew_name#</b></cfoutput> Crew.
                </h4>
            </div>
            <p>
<!---   Sub-Menu for Crew and Member Admin               --->
                <a href="crewPanel.cfm" class="link-secondary">Back to Crew Panel</a> | <a href="index.cfm" class="link-secondary">Home</a>
            </p>

<!---     Table that gives inputs to send invites this crew.   --->
            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mb-2">


                <table class="table table-striped table-bordered align-top" valign="top">
                    <thead>
                    <tr>
                      <th colspan="3" class="text-bg-success text-black">
                      <cfoutput>
                          Invite People to Your <b>#crew.crew_name#</b> Crew Below. You can invite up to 6 people at a time.
                      </cfoutput>
                      </th>
                    </tr>
                        <tr>
                          <th scope="col" class="rounded-start text-bg-primary">No.</th>
                          <th scope="col" class="text-bg-primary">Name</th>
                          <th scope="col" class="text-bg-primary">Email</th>                
                        </tr>
                    </thead>
                    <tbody>

                <form action="components/crewMembers.cfc" method="post">

                  <cfloop index="i" from="1" to="6">

                    <cfoutput>
                      <tr>                        
                          <td>#i#</td>  
                          <td>
                            <input type="text" class="form-control border border-info" name="name#i#" id="name#i#" placeholder="Name" required>
                          </td>
                          <td>
                            <input type="email" class="form-control border border-info" name="email#i#" id="email#i#" placeholder="Email Address" required>
                          </td>
                      </tr> 
                    </cfoutput>

                  </cfloop>    
                    <tr>
                        <td colspan="3">
                            <input type="text" class="form-control border border-info" name="addMessage" id="addMessage" placeholder="Additional Message">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="text-bg-success text-black">
                          <input type="hidden" name="Method" value="inviteMember">
                          <cfoutput>
                            <input type="hidden" name="cid" value="#url.cid#">
                          </cfoutput>
                          <input type="submit" class="btn btn-primary" value="Send Invite">
                        </td>
                      </tr>

                </form>

                    </tbody>
                </table>
            </div>
<!---     END of Table that gives inputs to send invites this crew.   --->


<!---     Table that shows all the Invited People, to this crew   --->
            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mb-2">


                <table class="table table-striped table-bordered align-top" valign="top">
                    <thead>
                    <tr>
                        <th colspan="5" class="text-bg-success text-black">
                        <cfoutput>
            
                            <cfif invitedPeople.recordcount neq 0>
                                #invitedPeople.recordcount# <cfif invitedPeople.recordcount neq 1>Invited People<cfelse>Invited Person</cfif> to <b>#crew.crew_name#</b> Crew.
                            </cfif>

                        </cfoutput>

                        <cfif url.delInvited neq 0>
                            <cfoutput>
                                <br><br><span class="text-danger">You have removed <b>#url.delInvited#</b> from your invited people list.</span>
                            </cfoutput>
                        </cfif>
                        </th>
                    </tr>
                        <tr>
                        <th scope="col" class="rounded-start text-bg-primary">No.</th>
                        <th scope="col" class="text-bg-primary">Name</th>
                        <th scope="col" class="text-bg-primary">Email<!--- /Phone---></th>
                        <th scope="col" class="text-bg-primary">Date Invited</th>
                        <th scope="col" class="rounded-end text-bg-primary">Delete</th>
                        </tr>
                    </thead>
                    <tbody>

                        <cfif invitedPeople.recordcount eq 0> 
                            <tr>
                                <td colspan="5">
                                    You have not invited any people to join this crew yet.  
                                    <br><br> 
                                    Invite people with the form below.
                                </td>
                            </tr>
                        </cfif>


                    <cfoutput query="invitedPeople">
                            <tr>
                                <th scope="row">#invitedPeople.currentRow#</th>
                                <td>#invitedPeople.name#<br>
                                </td>
                                <td class="text-sm">#invitedPeople.email# <!--- #members.phone#---></td>                                 
                                <td>#dateFormat(invitedPeople.date_invited,"mm/dd/yy h:mm")#</td>
                                <td>
                    <a href="##" class="link-success" data-bs-toggle="modal"
                    data-bs-target="##delInvitedModal" onclick="setDelInvitedInputs('#trim(invitedPeople.name)#', '#trim(invitedPeople.email)#')">delete</a><br>
                                </td>
                            </tr>
                    </cfoutput>

                    </tbody>
                </table>
            </div>
<!---     END of Table that shows all the Invited People, to this crew   --->

<!---  Table that shows all current Members of this crew   --->
            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mb-5">
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th colspan="5" class="text-bg-success text-black">
                        <cfoutput>
                            #members.recordcount# <cfif members.recordcount neq 1>Members<cfelse>Member</cfif> in <b>#crew.crew_name#</b> Crew.  
            

                        </cfoutput>

                        <cfif url.delUser neq 0>
                            <cfoutput>
                                <br><br><span class="text-danger">You have removed <b>#url.delUser#</b> from your crew.</span>
                            </cfoutput>
                        </cfif>
                        </th>
                    </tr>
                        <tr>
                        <th scope="col" class="rounded-start text-bg-primary">No.</th>
                        <th scope="col" class="text-bg-primary">Username</th>
                        <th scope="col" class="text-bg-primary">Email<!--- /Phone---></th>
                        <th scope="col" class="text-bg-primary">Name</th>
                        <th scope="col" class="rounded-end text-bg-primary">Update</th>
                        </tr>
                    </thead>
                    <tbody>

                        <cfif members.recordcount eq 0> 
                            <tr>
                                <td colspan="5">You have not invited any people to join this crew yet. <a href="createCrew.cfm">Create a Crew</a></td>
                            </tr>
                        </cfif>


                        <cfoutput query="members">
                            <tr>
                                <th scope="row">#members.currentRow#</th>
                                <td>#members.username#<br>
                                </td>
                                <td class="text-sm">#members.email# #members.phone#</td>                                
                                <td>#members.first_name# #members.last_name#</td>
                                <td>
                                    <a href="##" class="link-success" data-bs-toggle="modal"
                    data-bs-target="##delMemberModal" onclick="setFormInputs('#members.id#', '#members.username#')">delete</a><br>
                                </td>
                            </tr>


                        </cfoutput>
                        <cfif members.recordcount eq 0> 
                            <tr>
                                <td colspan="5">You have no Members of this crew yet. <a href="createCrew.cfm">Create a Crew</a></td>
                            </tr>
                        </cfif>
                    </tbody>
                    </table>
                </div>
<!---  END of Table that shows all current Members of this crew   --->


            </div>
        </div>

    </div>



        <!--  Delete Member Modal -->
    <div class="modal fade" id="delMemberModal" tabindex="-1" aria-labelledby="delMemberModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-info text-center">
                    <h2 class="modal-title w-100" id="delMemberModalLabel">Delete Member</h2>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body mx-auto">
                    <form action="components/crewMembers.cfc" method="post">
                        <div class="mb-3 align-items-center">
                            <div class="row mb-3">
                                <div class="col">
                                    <label for="username" class="form-label">Username to Delete</label>
                                    <input type="text" class="form-control border border-info" name="usernameToDelete"
                                        id="usernameToDelete" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                Are you sure you want to remove this user from your crew? <br>
                                That's pretty messed up.
                            </div>
                        </div>
                    </div>
                
                <div class="modal-footer bg-info" style="--bs-bg-opacity: .5;">

                    Yes, please remove this user from my crew!

                    <input type="hidden" name="Method" value="deleteMember">
                    <input type="hidden" name="memberToDelete" id="memberToDelete">
                    <cfoutput>
                        <input type="hidden" name="cid" value="#url.cid#">
                    </cfoutput>
                    

                    <button type="submit" class="btn btn-primary">Delete</button>

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>

                    </form>
            </div>
        </div>
    </div>
    <!--  END of Delete Member Modal -->

    <!--  Delete Invited Person Modal -->
    <div class="modal fade" id="delInvitedModal" tabindex="-1" aria-labelledby="delInvitedModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-info text-center">
                    <h2 class="modal-title w-100" id="delInvitedModalLabel">Delete Member</h2>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body mx-auto">
                    <form action="components/crewMembers.cfc" method="post">
                        <div class="mb-3 align-items-center">
                            <div class="row mb-3">
                                <div class="col">
                                    <label for="nameToDelete" class="form-label">Name to Delete</label>
                                    <input type="text" class="form-control border border-info" name="nameToDelete"
                                        id="nameToDelete" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3 align-items-center">
                            <div class="row mb-3">
                                <div class="col">
                                    <label for="emailToDelete" class="form-label">Email</label>
                                    <input type="text" class="form-control border border-info" name="emailToDelete"
                                        id="emailToDelete" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                Are you sure you want to remove this invited entry?  <br>
                            </div>
                        </div>
                    </div>
                
                <div class="modal-footer bg-info" style="--bs-bg-opacity: .5;">

                    Yes, please remove this entry!

                    <input type="hidden" name="Method" value="deleteInvited">
                    <cfoutput>
                        <input type="hidden" name="cid" value="#url.cid#">
                    </cfoutput>
                    

                    <button type="submit" class="btn btn-primary">Delete</button>

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>

                    </form>
            </div>
        </div>
    </div>
    <!--  END of Delete Invited Person Modal -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>



</body>

</html>