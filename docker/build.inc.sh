# Environment
function defineEnv() {
  
  export AUTHOR_DEFAULT="rydnr";
  export AUTHOR_DESCRIPTION="The author of the image(s) to build";
  if    [ "${AUTHOR+1}" != "1" ] \
     || [ "x${AUTHOR}" == "x" ]; then
    export AUTHOR="${AUTHOR_DEFAULT}";
  fi

  export AUTHOR_EMAIL="rydnr@acm-sl.org";
  export AUTHOR_EMAIL_DESCRIPTION="The author of the image(s) to build";
  if    [ "${AUTHOR_EMAIL+1}" != "1" ] \
     || [ "x${AUTHOR_EMAIL}" == "x" ]; then
    export AUTHOR_EMAIL="${AUTHOR_EMAIL_DEFAULT}";
  fi

  export NAMESPACE_DEFAULT="acmsl";
  export NAMESPACE_DESCRIPTION="The docker registry's namespace";
  if    [ "${NAMESPACE+1}" != "1" ] \
     || [ "x${NAMESPACE}" == "x" ]; then
    export NAMESPACE="${NAMESPACE_DEFAULT}";
  fi

  export DATE_DEFAULT="$(date '+%Y%m')";
  export DATE_DESCRIPTION="The date used to tag images";
  if    [ "${DATE+1}" != "1" ] \
     || [ "x${DATE}" == "x" ]; then
    export DATE="${DATE_DEFAULT}";
  fi

  export APIARYIO_TOKEN_DEFAULT="1b0c7fd6b43bf5d69cf23f365e47de42";
  export APIARYIO_TOKEN_DESCRIPTION="The apiary.io token";
  if    [ "${APIARYIO_TOKEN+1}" != "1" ] \
     || [ "x${APIARYIO_TOKEN}" == "x" ]; then
    export APIARYIO_TOKEN="${APIARYIO_TOKEN_DEFAULT}";
  fi
  
  export APIARYIO_API_NAME_DEFAULT="testapi468";
  export APIARYIO_API_NAME_DESCRIPTION="The apiary.io token";
  if    [ "${APIARYIO_API_NAME+1}" != "1" ] \
     || [ "x${APIARYIO_API_NAME}" == "x" ]; then
    export APIARYIO_API_NAME="${APIARYIO_API_NAME_DEFAULT}";
  fi
  
  export APIARYIO_PRIVATE_URL_DEFAULT="http://private-03998-${APIARYIO_API_NAME}.apiary-mock.com";
  export APIARYIO_PRIVATE_URL_DESCRIPTION="The private url in apiary.io";
  if    [ "${APIARYIO_PRIVATE_URL+1}" != "1" ] \
     || [ "x${APIARYIO_PRIVATE_URL}" == "x" ]; then
    export APIARYIO_PRIVATE_URL="${APIARYIO_PRIVATE_URL_DEFAULT}";
  fi
  
  ENV_VARIABLES=(\
    AUTHOR \
    AUTHOR_EMAIL \
    NAMESPACE \
    APIARYIO_TOKEN \
    APIARYIO_API_NAME \
    APIARYIO_PRIVATE_URL \
   );
 
  export ENV_VARIABLES;
}
