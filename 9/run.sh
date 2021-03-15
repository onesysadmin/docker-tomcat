#!/bin/sh

WEBAPPS_DIR=${CATALINA_HOME}/webapps

# ash shell workaround to grep for tag names
REMOVE_PATH=${SERVICE_TAGS/http-path/}

# rename ROOT.war and ROOT/ to SERVICE_NAME if it exists
# and the service is tagged with http-path or http-subdomain
# this will force the ROOT app to be under a context path
if [[ "${#REMOVE_PATH}" -lt "${#SERVICE_TAGS}" -a ! -z "$SERVICE_NAME" ]]; then
  if [ -d "${WEBAPPS_DIR}/ROOT" ]; then
    rm -rf ${WEBAPPS_DIR}/${SERVICE_NAME}
    mv ${WEBAPPS_DIR}/ROOT ${WEBAPPS_DIR}/${SERVICE_NAME}
    echo "Renaming ROOT directory to ${SERVICE_NAME}"
  fi
  if [ -f "${WEBAPPS_DIR}/ROOT.war" ]; then
    rm -rf ${WEBAPPS_DIR}/${SERVICE_NAME}.war
    mv ${WEBAPPS_DIR}/ROOT.war ${WEBAPPS_DIR}/${SERVICE_NAME}.war
    echo "Renaming ROOT.war to ${SERVICE_NAME}.war"
  fi
fi

if [ ! -f /.tomcat_admin_created ]; then
  /create_tomcat_admin_user.sh
fi

exec ${CATALINA_HOME}/bin/catalina.sh run

