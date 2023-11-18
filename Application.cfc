component {
    this.name = "crewdig";
    this.datasource = "crewdig";
    this.sessionManagement = true;
    this.sessiontimeout=#CreateTimeSpan(0,1,0,0)#
    this.loginStorage = "cookie";
    this.setClientCookies = true;
    this.currentPath = getDirectoryFromPath(getCurrentTemplatePath());


    function onRequestStart() {
        application.appBasePath = expandPath("/");     
    }
 }

