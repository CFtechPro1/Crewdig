<cfcomponent>

    <!--- Add New Crew function --->

    <cffunction name="addNewCrew" access="remote" hint="Adds new crew by logged in User.">

        <cfargument name="crewName" type="string" required="true">
        <cfargument name="crewDesc" type="string" required="true">
        <cfargument name="crewCat" type="integer" required="true">
        <cfargument name="private" type="integer" default=1>

        <cfquery name="addCrew" result="crewAddedId">
            INSERT INTO c_crews (uid, crew_name, crew_desc, private, category)
            VALUES (
                    <cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer">, 
                    <cfqueryparam value="#trim(arguments.crewName)#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#trim(arguments.crewDesc#)#" cfsqltype="cf_sql_varchar">, 
                    <cfqueryparam value="#arguments.private#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#arguments.crewCat#" cfsqltype="cf_sql_integer">)
        </cfquery>

        <cfif isDefined("crewAddedId.generatedKey")>
            <cflocation url="../crewPanel.cfm?crewAdded=1">
        </cfif>

    </cffunction> 

    <!--- End Add New Crew function --->

</cfcomponent>
```