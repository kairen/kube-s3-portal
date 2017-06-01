#!/bin/sh
#
# Program: Running apache script
#

set -ex
cd /app

# Database default value
DB_HOST=${DB_HOST:-"localhost"}
DB_NAME=${DB_NAME:-"ceph"}
DB_USER=${DB_USER:-"root"}
DB_PWD=${DB_PWD:-"root"}

# Ceph radosgw s3 default value
S3_ACCESS_KEY=${S3_ACCESS_KEY:-""}
S3_SECERT_KEY=${S3_SECERT_KEY:-""}
S3_REGION=${S3_REGION:-"default"}
S3_URL=${S3_URL:-"s3.example.com"}
S3_PORT=${S3_PORT:-"7480"}
S3_ADMIN_ENRTYPOINT=${S3_ADMIN_ENRTYPOINT:-"admin"}

CEPH_REST_API_PORT=${CEPH_REST_API_PORT:-"5000"}
DEFAULT_CAPACITY_KB=${DEFAULT_CAPACITY_KB:-"50"}

LINK_DB_HOST=$(awk '/db / {print $1}' /etc/hosts)

if [ ! -z ${LINK_DB_HOST} ]; then
    DB_HOST=${LINK_DB_HOST}
fi

function initial() {
    php artisan key:generate
    php artisan jwt:generate
    php artisan migrate
    php artisan db:seed
    touch /fake
}

echo "-------- Database conf --------"
echo "Your database Host : ${DB_HOST}"
echo "Your database name : ${DB_NAME}"
echo "Your database username : ${DB_USER}"
echo "Your database password : ${DB_PWD}"

echo "-------- S3 conf --------"
echo "Your s3 access key : ${S3_ACCESS_KEY}"
echo "Your s3 secret key : ${S3_SECERT_KEY}"
echo "Your s3 region : ${S3_REGION}"
echo "Your s3 server URL : ${S3_URL}"
echo "Your s3 server port : ${S3_PORT}"
echo "Your s3 admin entrypoint : ${S3_ADMIN_ENRTYPOINT}"
echo "Your ceph rest api port : ${CEPH_REST_API_PORT}"
echo "Your default capacity : ${DEFAULT_CAPACITY_KB} KB"

# Database configuration
sed -i "s/DB_HOST=.*/DB_HOST=${DB_HOST}/g" .env
sed -i "s/DB_DATABASE=.*/DB_DATABASE=${DB_NAME}/g" .env
sed -i "s/DB_USERNAME=.*/DB_USERNAME=${DB_USER}/g" .env
sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=${DB_PWD}/g" .env

# Ceph radosgw configuration
sed -i "s/AccessKey=.*/AccessKey=${S3_ACCESS_KEY}/g" .env
sed -i "s/SecretKey=.*/SecretKey=${S3_SECERT_KEY}/g" .env
sed -i "s/Region=.*/Region=${S3_REGION}/g" .env
sed -i "s/ServerURL=.*/ServerURL=${S3_URL}/g" .env
sed -i "s/RGWPort=.*/RGWPort=${S3_PORT}/g" .env
sed -i "s/AdminEntryPoint=.*/AdminEntryPoint=${S3_ADMIN_ENRTYPOINT}/g" .env
sed -i "s/CephRestAdminServerPort=.*/CephRestAdminServerPort=${CEPH_REST_API_PORT}/g" .env
sed -i "s/UserDefaultCapacityKB=.*/UserDefaultCapacityKB=${DEFAULT_CAPACITY_KB}/g" .env

echo -e "\nWait for database start..."
php check.php &>/dev/null

# Initial database
[ ! -f /fake ] && initial

sed -i "s/#ServerName www.example.com:80/ServerName localhost/" /etc/apache2/httpd.conf
rm -f /usr/local/apache2/logs/httpd.pid

echo "[i] Starting daemon..."
httpd -D FOREGROUND
