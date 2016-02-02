#!/bin/sh

WEBAPPS_DIR=${CATALINA_HOME}/webapps

# rename ROOT.war and ROOT/ to SERVICE_NAME if it exists
# this will force the ROOT app to be under a context path
if [ ! -z "$SERVICE_NAME" ]; then
  rm -rf ${WEBAPPS_DIR}/${SERVICE_NAME} ${WEBAPPS_DIR}/${SERVICE_NAME}.war
	if [ -d "${WEBAPPS_DIR}/ROOT" ]; then
		mv ${WEBAPPS_DIR}/ROOT ${WEBAPPS_DIR}/${SERVICE_NAME}
		echo "Renaming ROOT directory to ${SERVICE_NAME}"
	fi
	if [ -f "${WEBAPPS_DIR}/ROOT.war" ]; then
		mv ${WEBAPPS_DIR}/ROOT.war ${WEBAPPS_DIR}/${SERVICE_NAME}.war
		echo "Renaming ROOT.war to ${SERVICE_NAME}.war"
	fi
fi

if [ ! -f /.tomcat_admin_created ]; then
    /create_tomcat_admin_user.sh
fi

exec ${CATALINA_HOME}/bin/catalina.sh run
