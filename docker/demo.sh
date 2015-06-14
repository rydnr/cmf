#!/bin/bash dry-wit
# Copyright 2015-today Automated Computing Machinery S.L.
# Distributed under the terms of the GNU General Public License v3

function usage() {
cat <<EOF
$SCRIPT_NAME [-v[v]] [-q|--quiet] token domain [url*]
$SCRIPT_NAME [-h|--help]
(c) 2015-today Automated Computing Machinery S.L.
    Distributed under the terms of the GNU General Public License v3
 
Runs a Docker image with a custom Apache server, acting as a
man-in-the-middle for given domain, allowing the HTML content
be modified within apiary.io.

Where:
  * token: the apiary.io token (from https://login.apiary.io/tokens)
  * domain: the domain to mock.
  * url: the urls to intercept.
EOF
}

DOCKER=$(which docker.io 2> /dev/null || which docker 2> /dev/null)

# Requirements
function checkRequirements() {
  checkReq ${DOCKER} DOCKER_NOT_INSTALLED;
}
 
# Error messages
function defineErrors() {
  export INVALID_OPTION="Unrecognized option";
  export DOCKER_NOT_INSTALLED="docker is not installed";
  export TOKEN_IS_MANDATORY="Token is mandatory";
  export DOMAIN_IS_MANDATORY="Domain is mandatory";
  export ERROR_RUNNING_DOCKER_IMAGE="Error running Docker image";

  ERROR_MESSAGES=(\
    INVALID_OPTION \
    DOCKER_NOT_INSTALLED \
    TOKEN_IS_MANDATORY \
    DOMAIN_IS_MANDATORY \
    ERROR_RUNNING_DOCKER_IMAGE \
  );

  export ERROR_MESSAGES;
}
 
# Checking input
function checkInput() {

  local _flags=$(extractFlags $@);
  local _flagCount;
  local _currentCount;
  logDebug -n "Checking input";

  # Flags
  for _flag in ${_flags}; do
    _flagCount=$((_flagCount+1));
    case ${_flag} in
      -h | --help | -v | -vv | -q)
         shift;
         ;;
      *) exitWithErrorCode INVALID_OPTION ${_flag};
         ;;
    esac
  done
 
  # Parameters
  if [ "x${APIARYIO_API_TOKEN}" == "x" ]; then
    APIARYIO_API_TOKEN="$1";
    shift;
  fi

  if [ "x${APIARYIO_API_TOKEN}" == "x" ]; then
    logDebugResult FAILURE "fail";
    exitWithErrorCode TOKEN_IS_MANDATORY;
  else
    logDebugResult SUCCESS "valid";
  fi 

  if [ "x${DOMAIN}" == "x" ]; then
    DOMAIN="$1";
    shift;
  fi

  if [ "x${DOMAIN}" == "x" ]; then
    logDebugResult FAILURE "fail";
    exitWithErrorCode DOMAIN_IS_MANDATORY;
  else
    logDebugResult SUCCESS "valid";
  fi 

  if [ "x${URLS}" == "x" ]; then
    URLS="$@";
    shift;
  fi
  
  if [ "x${URLS}" == "x" ]; then
    URLS="/";
  fi
}

[ -e "$(dirname ${SCRIPT_NAME})/$(basename ${SCRIPT_NAME} .sh).inc.sh" ] && source "$(dirname ${SCRIPT_NAME})/$(basename ${SCRIPT_NAME} .sh).inc.sh"

function main() {
    sudo sh -c "(echo 127.0.0.1 localhost ${DOMAIN}; grep -v '127.0.0.1' /etc/hosts) > /tmp/hosts && mv /tmp/hosts /etc/hosts"
    sudo docker run -d -p 80:80 -p 443:443 -e APIARY_API_KEY="${APIARYIO_API_TOKEN}" \
        -e VIRTUAL_HOST=${DOMAIN} -e URLS="${URLS}" acmsl/pagecare-demo-mock
}
