<cfcomponent>

    <!---Login User function--->
    <cffunction name="loginUser" access="remote" returnType="string">
        <cfargument name="username" type="string" default="">
        <cfargument name="password" type="string" required="true">
        <cfargument name="email" type="string" default="">


    <cfif trim(arguments.email) neq "">

        <cfquery name="users">
            SELECT id, username, password, email, COUNT(*) AS userExists FROM c_users WHERE email = '#trim(form.email)#' AND password = '#trim(form.password)#' group by id, username, password, email
        </cfquery>

    </cfif>
            
        <cfif users.recordcount eq 1>    
            <cfif users.userExists EQ 1>
                <cfset session.uid = users.id>
                <cfset session.username = users.username>
                <cfset session.password = users.password>
                <cfset session.userExists = 1>
                <cfset session.loggedIn = true>
                <cflocation url="../crewPanel.cfm?username=#session.username#">
            </cfif>
        <cfelse>
            <cflocation url="../index.cfm?nolog=1">
        </cfif>
 
    </cffunction>
    <!---End Login User function--->


    <!---Logout User function--->
    <cffunction name="logoutUser" access="remote" returnType="string">
        <cfset session.uid = 0>
        <cfset session.username = "">
        <cfset session.password = "">
        <cfset session.userExists = 0>
        <cfset session.loggedIn = false>
        <cflocation url="../index.cfm?logout=1">
    </cffunction>
    <!---End Logout User function--->


<!---Sign Up User function--->

    <cffunction name="signUpUser" access="remote" returnType="string">
        <cfargument name="username" type="string" required="true">
        <cfargument name="password" type="string" required="true">
        <cfargument name="confirmPassword" type="string" required="true">
        <cfargument name="email" type="string" required="true">
        <cfargument name="firstName" type="string" required="true">
        <cfargument name="lastName" type="string" required="true">


        <cfquery name="existingUser">
            SELECT username, password, email FROM c_users WHERE email = '#trim(arguments.email)#' group by username, password, email
        </cfquery>

    <cfif existingUser.recordcount eq 1>

        <cflocation url="../index.cfm?userExists=1">
        
    <cfelse>

        <cfif trim(arguments.password) EQ trim(arguments.confirmPassword)>
            <cfquery name="users" result="newUserId">
                INSERT INTO c_users (username, password, email, first_name, last_name) 
                VALUES
                (<cfqueryparam value='#trim(arguments.username)#' cfsqltype="cf_sql_varchar">,<cfqueryparam value='#trim(arguments.password)#' cfsqltype="cf_sql_varchar">,<cfqueryparam value='#trim(arguments.email)#' cfsqltype="cf_sql_varchar">,
                <cfqueryparam value='#trim(arguments.firstName)#' cfsqltype="cf_sql_varchar">,<cfqueryparam value='#trim(arguments.lastName)#' cfsqltype="cf_sql_varchar">)
            </cfquery>

         

            <cfif isDefined("newUserId.generatedKey")>

                <cfquery name="newUser">
                    SELECT id, username, password, email, first_name, last_name FROM c_users WHERE id = #newUserId.generatedKey# group by id, username, password, email, first_name, last_name
                </cfquery>

                <cfset session.uid = newUser.id>
                <cfset session.username = newUser.username>
                <cfset session.password = newUser.password>
                <cfset session.email = newUser.email>
                <cfset session.firstName = newUser.first_name>
                <cfset session.lastName = newUser.last_name>
                <cfset session.userExists = 1>
                <cfset session.loggedIn = true>            
                
                        <!--- Add default crew for this new user. --->
                    <cfquery name="addCrew">
                        INSERT INTO c_crews (uid, crew_name, crew_desc, private, category) 
                        VALUES
                        (#newUser.id#,"#newUser.username# default crew","#newUser.username# default crew description.",1,1)  
                    </cfquery>  

                <cflocation url="../crewPanel.cfm?username=#session.username#">
            </cfif>

        <cfelse>
            <cflocation url="../index.cfm?misslog=1">
        </cfif>

    </cfif>
            
        <cfif users.recordcount eq 1>
            <cfif users.userExists EQ 1>
                <cfset session.username = users.username>
                <cfset session.password = users.password>
                <cfset session.userExists = 1>
                <cfset session.loggedIn = true>
                <cfset session.message = "You have successfully logged in.">
                <cflocation url="../crewPanel.cfm?username=#session.username#&password=#session.password#">
            </cfif>
        <cfelse>
            <cflocation url="../index.cfm?nolog=1">
        </cfif>
 
    </cffunction>   
    <!---End Sign Up User function--->


  <!---Forgot Password function--->
    <cffunction name="forgotPassword" access="remote" returnType="string">
        <cfargument name="email" type="string" default="">


        <cfif trim(arguments.email) neq "">

            <cfquery name="user">
                SELECT username, password, email FROM c_users WHERE email = '#trim(form.email)#' group by username, password, email
            </cfquery>

        </cfif>
            
        <cfif users.recordcount eq 1>    
            <cfmail  from="cftechpro1@gmail.com"  subject="CREWDIG.com Login Instructions"  to="#user.email#">
                <cfoutput>
                    <p>Dear #user.username#,</p>

                    <p>Here are your login details:</p>

                    <p><b>Username:</b> #user.username#</p>

                    <p><b>Password:</b> #user.password#</p>

                    <p>You can change your password from within your Crew Panel once you have logged in.</p>
                    
                    <p>Thank you for using CREWDIG.com!</p>
                </cfoutput>
            </cfmail>
        <cfelse>
            <cflocation url="../index.cfm?nolog=1">
        </cfif>
    
    </cffunction>
    <!---End Forgot Password function--->

</cfcomponent>