#!/bin/bash
# Program:
#       This program is install boot run script.
# History:
# 2016/05/03 Kyle Bai Release
#
set -e
cd /app

# Application  database environment var
DB_HOST=${DB_HOST:-""}
DB_DATABASE=${DB_DATABASE:-"ceph"}
DB_USERNAME=${DB_USERNAME:-"root"}
DB_PASSWORD=${DB_PASSWORD:-"r00tme"}
LINK_DB_HOST=$(awk '/db / {print $1}' /etc/hosts)

if [ ! -z ${LINK_DB_HOST} ]; then
    DB_HOST=${LINK_DB_HOST}
fi

if [ -z ${DB_HOST} ]; then
    echo "ERROR: Must provide a MySQL ..."
    exit 1
fi

if [ -z ${ACCESS_KEY} ]; then
    echo "ERROR: Must provide radosgw admin access key ..."
    exit 1
fi
ACCESS_KEY=${ACCESS_KEY:-""}

if [ -z ${SECERT_KEY} ]; then
    echo "ERROR: Must provide radosgw admin secret key ..."
    exit 1
fi

# Application ceph radosgw environment var
SECERT_KEY=${SECERT_KEY:-""}
REGION=${REGION:-"default"}
S3_URL=${S3_URL:-"s3.example.com"}
ADMIN_ENRTYPOINT=${ADMIN_ENRTYPOINT:-"admin"}

echo "-------- Database conf --------"
echo "Your database Host : ${DB_HOST}"
echo "Your database name : ${DB_DATABASE}"
echo "Your database username : ${DB_USERNAME}"
echo "Your database password : ${DB_PASSWORD}"

echo "-------- S3 conf --------"
echo "Your s3 access key : ${ACCESS_KEY}"
echo "Your s3 secret key : ${SECERT_KEY}"
echo "Your s3 region : ${REGION}"
echo "Your s3 server URL : ${S3_URL}"
echo "Your s3 admin entrypoint : ${ADMIN_ENRTYPOINT}"

# Generating Application Key
php artisan key:generate

# Generating JWT Key
php artisan jwt:generate

# Database configuration
sed -i "s/DB_HOST=.*/DB_HOST=${DB_HOST}/g" .env
sed -i "s/DB_DATABASE=.*/DB_DATABASE=${DB_DATABASE}/g" .env
sed -i "s/DB_USERNAME=.*/DB_USERNAME=${DB_USERNAME}/g" .env
sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=${DB_PASSWORD}/g" .env

# Ceph radosgw configuration
sed -i "s/AccessKey=.*/AccessKey=${ACCESS_KEY}/g" .env
sed -i "s/SecretKey=.*/SecretKey=${SECERT_KEY}/g" .env
sed -i "s/Region=.*/Region=${REGION}/g" .env
sed -i "s/ServerURL=.*/ServerURL=${S3_URL}/g" .env
sed -i "s/AdminEntryPoint=.*/AdminEntryPoint=${ADMIN_ENRTYPOINT}/g" .env

# Starting s3-backend process
rm -rf /etc/apache2/sites-enabled/000-default.conf

echo "Wait for database start"
while [ ! $(nmap -p 3306 -sT ${DB_HOST} | grep "open  mysql" -c) -gt 0 ]; do sleep 0.5; done

php artisan migrate
a2ensite s3-backend
a2enmod rewrite
bash /run.sh
