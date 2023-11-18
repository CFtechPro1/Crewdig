<cfcomponent>

        <!--- Function that deletes a member from the c_members table using the sent in mid parameter. then cflocation back to the crewpanel.cfm page. 
        --->    
    <cffunction name="deleteMember" access="remote" returntype="void">

        <cfargument name="memberToDelete" type="numeric" required="yes">
        <cfargument name="usernameToDelete" type="string" required="yes">
        <cfargument name="cid" type="integer" required="yes">
     
        <cfquery name="deleteMember">
            DELETE FROM c_members
            WHERE id = <cfqueryparam value="#arguments.memberToDelete#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cflocation  url="../viewMembers.cfm?cid=#arguments.cid#&delUser=#arguments.usernameToDelete#" addtoken="no">

    </cffunction>

    
        <!--- Function that deletes an invited person from the c_invited table using the sent in email and name parameter. then cflocation back to the inviteMembers.cfm page. 
        --->    
    <cffunction name="deleteInvited" access="remote" returntype="void">

        <cfargument name="nameToDelete" type="string" required="yes">
        <cfargument name="emailToDelete" type="string" required="yes">
        <cfargument name="cid" type="integer" required="yes">
     
        <cfquery name="deleteMember">
            DELETE FROM c_invited
            WHERE email = <cfqueryparam value="#arguments.emailToDelete#" cfsqltype="cf_sql_varchar">
            AND cid = <cfqueryparam value="#arguments.cid#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cflocation  url="../inviteMembers.cfm?cid=#arguments.cid#&delInvited=#arguments.nameToDelete#" addtoken="no">

    </cffunction>
<!---   End of deleteInvited function --->


            <!--- Function that Invites people to the crew using the sent in email and name parameter. then cflocation back to the inviteMembers.cfm page.
            --->
    <cffunction name="inviteMembers" access="remote" returntype="void">

            <!--- Get form data (replace with actual form field names) --->
            <cfset cid = trim(form.cid)>

            
        <cfloop index="i" from="1" to="6">
            <cfset emailAddress = trim(form["email#i#"])>
            <cfset recipientName = trim(form["name#i#"])>
            <cfset addMessage = trim(form["message#i#"])>

            <cfif emailAddress neq "">
                
                <!--- Send the email --->
                <cftry>
                    <cfmail to="#emailAddress#" subject="You have been Invited to Join #session.first_name# #session.first_name#'s Crew" from="#session.email#">
                        <cfmailparam name="format" value="text/plain">
                        <cfmailparam name="charset" value="utf-8">
                        
                        Hello #recipientName#!

                        You have been invited to join #session.first_name# #session.last_name#'s Crew on CREWDIG.com. The new place to create crews and get thier input on anything! Please click on the link below to join.

                        http://www.crewdig.com/crew/joinCrew.cfm?cid=#cid#

                        <cfif addMessage neq "">
                                <b>Message from #session.first_name# #session.last_name#:

                            #addMessage#
                        </cfif>

                        Thank you for using CREWDIG.com!

                    </cfmail>
                    <cfset emailSent = true>
                    <cfcatch>
                        <cfset emailSent = false>
                    </cfcatch>
                </cftry>

                <cfif emailSent>
                    <cfquery name="addInvited" datasource="crew">
                        INSERT INTO c_invited (cid, name, email)
                        VALUES (<cfqueryparam value="#cid#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#recipientName#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#emailAddress#" cfsqltype="cf_sql_varchar">)
                    </cfquery>
                </cfif>   
            </cfif>
        </cfloop>

    </cffunction>


<!---     End of Invite Members Function. --->

</cfcomponent>