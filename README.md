
### Building Your Webapp

This container image is really meant to be imported and inherited from so you can include your webapp.

Your main webapp should be placed either in ${CATALINA_HOME}/webapps/ROOT/ folder (you need to create this)
or as a war file located at ${CATALINA_HOME}/webapps/ROOT.war.  This will deploy your webapp at the root "/"
context.  

You can then use the SERVICE_NAME environment variable to change the app context path.

### Environment Variables

Aside from TOMCAT environment variables, the following environment variables are
supported by our container:

* TOMCAT_PASS - Sets the admin password for the tomcat manager.  If not set, then a password will be randomly generated. The password will be shown in output when the container is launched.

* SERVICE_NAME - Sets the context path for the app.  When this is set and detected, ROOT/ or ROOT.war will be renamed to the value of this environment variable.  When tomcat is launched, the app will be deployed under this context path.  For example, if SERVICE_NAME is set to _abc_, then the app will be access via `http://host:8080/abc/`.
