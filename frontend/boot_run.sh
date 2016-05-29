#!/bin/bash
# Program:
#       This program is install boot run script.
# History:
# 2016/05/03 Kyle Bai Release
#
set -e

BACKEND_ADDRESS=${BACKEND_ADDRESS:-"127.0.0.1:8080"}
SSL_ENABLE=${SSL_ENABLE:-false}

echo "Your s3 portal backend address : ${BACKEND_ADDRESS}"

# Generating s3-portal-ui config file
URL="http:\/\/127.0.0.1:8080"
NEW_URL="http:\/\/${BACKEND_ADDRESS}"

if ${SSL_ENABLE}; then
    NEW_URL="https:\/\/${BACKEND_ADDRESS}"
fi

cd /opt/app
sed -i "s/${URL}/${NEW_URL}/g" config.js

# Starting s3-frontend process
/usr/local/bin/npm start
