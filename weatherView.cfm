
<!--- weatherView.cfm --->
<cfset weatherService = new WeatherService(apiKey="4cfef693dc483952ebeb2fa0483f9adc")>

<!--- Function to get the auth token from Universal Tutorial API --->
<cffunction name="getAuthToken" access="public" returntype="string">
    <cfhttp url="https://www.universal-tutorial.com/api/getaccesstoken" method="get" result="authResponse">
        <cfhttpparam type="header" name="Accept" value="application/json">
        <cfhttpparam type="header" name="api-token" value="ecExBwwTrUTcf5jWAYyXBYZHR6P4JANOO2NAZk-lYhQPfYtcppfrWDvWbA-S8CnkjIg">
        <cfhttpparam type="header" name="user-email" value="dtkelly72@yahoo.com">
    </cfhttp>
    <cfreturn deserializeJson(authResponse.filecontent).auth_token>
</cffunction>

<!--- Get auth token --->
<cfset authToken = getAuthToken()>

<!--- Function to get states data --->
<cffunction name="getStates" access="public" returntype="array">
    <cfhttp url="https://www.universal-tutorial.com/api/states/United States" method="get" result="statesResponse">
        <cfhttpparam type="header" name="Authorization" value="Bearer #authToken#">
        <cfhttpparam type="header" name="Accept" value="application/json">
    </cfhttp>
    <cfreturn deserializeJson(statesResponse.filecontent)>
</cffunction>

<!--- Get states data --->
<cfset states = getStates()>

<html>
<head>
    <!-- Include necessary CSS and JS -->
    <script>
        // JavaScript to update city dropdown based on state selection
        async function updateCityDropdown() {
            const selectedState = document.getElementById('stateSelect').value;
            const response = await fetch('index.cfm?state=' + selectedState);
            const cities = await response.json();
            let citySelect = document.getElementById('citySelect');
            citySelect.innerHTML = cities.map(city => `<option value="${city.city_name}">${city.city_name}</option>`).join('');
        }
    </script>
</head>
<body>
    <form method="post">
        <select name="state" id="stateSelect" onchange="updateCityDropdown()">
            <cfloop array="#states#" index="state">
                <option value="#state.state_name#">#state.state_name#</option>
            </cfloop>
        </select>

        <select name="city" id="citySelect">
            <!-- Cities will be populated based on selected state -->
        </select>

        <input type="submit" value="Get Weather">
    </form>

    <!-- Display weather data -->
    <cfif structKeyExists(form, "state") and structKeyExists(form, "city")>
        <cfset weather = weatherService.getWeather(form.city)>
        <!-- Display weather data -->
    </cfif>
</body>
</html>
