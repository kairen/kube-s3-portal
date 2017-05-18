#!/bin/sh
#
# Program: Running nodejs script
#

set -eu
cd /app

API_HOST=${API_HOST:-"127.0.0.1:8080"}
ENABLE_SSL=${ENABLE_SSL:-false}

echo "Your s3 portal backend address : ${API_HOST}"

# Set s3-portal-ui config file
URL="http:\/\/127.0.0.1:8080"
NEW_URL="http:\/\/${API_HOST}"

if ${ENABLE_SSL}; then
    NEW_URL="https:\/\/${API_HOST}"
fi

sed -i "s/${URL}/${NEW_URL}/g" config.js

# Starting s3-frontend process
npm start
