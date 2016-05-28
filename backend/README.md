# Ceph S3 Backend
快速建置一個 Ceph S3 Backend Server 可以透過以下指令進行部署：
```sh
$ docker run -d -p 8080:80 --name backend --link db:database \
-e S3_URL="<s3_server_url>" \
-e ADMIN_ENRTYPOINT ="admin" \
-e ACCESS_KEY="<access_key>" \
-e SECERT_KEY="<secret_key>" \
imaccloud/s3-api:0.1.0
```
