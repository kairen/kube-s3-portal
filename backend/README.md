# Ceph S3 Portal API
本專案將 Ceph S3 Portal API 建置為 Docker 容器應用程式。若要建立映像檔，可以透過以下指令進行：
```sh
$ docker build -t kairen/s3-portal-api:latest .
```

# Quick Start
目前已經有建立最新版本的 Ceph S3 Portal API 於 [DockerHub](https://hub.docker.com/r/kairen/s3-portal-api/)。

快速部署一個 Ceph S3 Portal API 可以透過以下指令進行：
```sh
$ docker run -d -p 8080:80 --name backend  \
-e DB_HOST="<db_host>" -e DB_DATABASE="db_name" \
-e DB_USERNAME="<db_user>" -e DB_PASSWORD="db_passwd" \
-e S3_URL="<s3_url>" -e ADMIN_ENRTYPOINT="<admin_entrypoint>" \
-e ACCESS_KEY="<admin_access_key>" \
-e SECERT_KEY="<admin_secert_key>" \
kairen/s3-portal-api:latest
```
> 注意! 這邊的`ACCESS_KEY`與`SECERT_KEY`必須是擁有`caps`權限。可以透過以下方式建立：
```sh
$ radosgw-admin caps add --uid="<admin_uid>" --caps="users=*"
```
> 其他參數設定如下所示：
```
--caps="[users|buckets|metadata|usage|zone]=[*|read|write|read, write]"
```
