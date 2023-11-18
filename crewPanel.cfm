<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crewdig.com - Your Crew Knows What's Good</title>

     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>

<body>

    <!---Nav Bar Menu--->

    <cfinclude  template="navBarMenu.cfm">
    
    <!---End Nav Bar Menu---> 

    <cfquery name="crews">
        SELECT id, uid, crew_name, crew_desc, private, crew_pic, category, crew_password FROM c_crews WHERE uid = #session.uid# 
    </cfquery>


    <div class="container-fluid bg-info" style="--bs-bg-opacity: .3;">
        <div class="row">
            <div class="col-12 text-center">
                <h2 class="display-6">
                    <cfif isDefined("session.username")>
                        Welcome <cfoutput>#session.username#!</cfoutput>
                    <cfelse>
                        <cflocation  url="index.cfm?trylog=1">
                    </cfif>
                </h2>
            </div>
        </div>
        <div class="px-4 pt-1 my-1 text-center border-bottom">
            <h3 class="display-4 fw-bold text-body-emphasis">Crew Panel</h3>
            <div class="col-lg-9 mx-auto">
                <div class="row my-auto">
                    <div class="col text-center bg-info rounded-3 mx-2 p-2 border border-success"
                        style="--bs-bg-opacity: .4;">
                        Create a Crew and invite people to join.
                    </div>
                    <div class="col text-center bg-info rounded-3 mx-2 p-2 border border-success"
                        style="--bs-bg-opacity: .4;">
                        Create Questions and add Text & Pictures for your crew to vote on.
                    </div>
                    <div class="col text-center bg-info rounded-3 mx-2 p-2 border border-success"
                        style="--bs-bg-opacity: .4;">
                        See which option your crew likes best.
                    </div>
                    <div class="col text-center bg-info rounded-3 mx-2 p-2 border border-success"
                        style="--bs-bg-opacity: .4;">
                        Create as many Crews & Questions as you like!
                    </div>
                </div>
            </div>
            <p>
            </p>
            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mb-5">

                <table class="table">
                    <thead>
                        <tr>
                        <th scope="col" class="rounded-start text-bg-primary">No.</th>
                        <th scope="col" class="text-bg-primary">Crew Name</th>
                        <th scope="col" class="text-bg-primary">Crew Description</th>
                        <th scope="col" class="text-bg-primary">Members</th>
                        <th scope="col" class="text-bg-primary">Questions</th>
                        <th scope="col" class="rounded-end text-bg-primary">Edit/Update</th>
                        </tr>
                    </thead>
                    <tbody>

                <cfoutput query="crews"> <!---Get all the crews for this user.--->

                    <!--- query to get the questions count for this crew from the c_questions table.--->
                    <cfquery name="questions#crews.id#">
                        SELECT id, uid, cid FROM c_questions WHERE cid = #crews.id#
                    </cfquery>
                    
                    <cfset questionCount = Evaluate("questions#crews.id#.recordcount")>

                    <!--- query to get the members for this crew from the c_members table.--->
                    <cfquery name="members#crews.id#">
                        SELECT id, uid, cid FROM c_members WHERE cid = #crews.id#
                    </cfquery>

                    <cfset memberCount = Evaluate("members#crews.id#.recordcount")>

                            <tr>
                                <th scope="row">#crews.currentRow#</th>
                                <td>#crews.crew_name#<br>
                                    <a href="editCrew.cfm?crewid=#crews.id#" class="link-success">Edit Crew Name</a>
                                </td>
                                <td>#left(crews.crew_desc, 200)#<br>                                  
                                    <a href="editCrew.cfm?crewid=#crews.id#" class="link-success">Edit Crew Description</a>
                                </td>
                                <td class="text-sm">
                                    <a href="viewMembers.cfm?cid=#crews.id#" class="link-success">
                                        #memberCount#
                                    </a>
                                </td>
                                <td class="text-sm">
                                    <a href="viewQuestions.cfm?cid=#crews.id#" class="link-success">
                                        #questionCount#
                                    </a>
                                </td>
                                <td>
                                    <a href="viewQuestions.cfm?cid=#crews.id#" class="link-success">Create/Edit Questions</a>
                                    <br>
                                    <a href="viewMembers.cfm?cid=#crews.id#" class="link-success">View Crew Members</a><br>
                                </td>
                            </tr>
                        </cfoutput>
                        <cfif crews.recordcount eq 0> 
                            <tr>
                                <td colspan="5">You have no Crews. <a href="createCrew.cfm">Create a Crew</a></td>
                            </tr>
                        </cfif>
                    </tbody>
                    </table>

            </div>
            <div>
                <div class="container px-5">
                    other text
                </div>
            </div>
        </div>

    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>



</body>

</html>