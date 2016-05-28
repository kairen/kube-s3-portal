#!/bin/bash
# Program:
#       This program is install boot run script.
# History:
# 2016/05/03 Kyle Bai Release
#
BACKEND_URL=${BACKEND_URL:-"http://127.0.0.1"}

echo "Your s3 portal backend URL : ${BACKEND_URL}"

# Generating s3-portal-ui config file
cd /opt/app
echo -e "
module.exports = {
  NODE_ENV: process.env.NODE_ENV || 'development',
  SERVER_HOST: '${BACKEND_URL}',
};
" > config.js

# Starting s3-frontend process
/usr/local/bin/npm start
