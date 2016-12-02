# Dockerize Ceph S3 Portal
本專案說明如何透過 Dockerfile 部署 Ceph S3 Portal 前端與後端服務，目前已提供 Docker Compose 來快速建置。

### Quick Start
透過 docker-compose 執行的話，請修改`docker-compose.yml`檔案，然後修改以下內容：
```yaml
db:
  image: mysql:5.6
  container_name: db
  environment:
    MYSQL_DATABASE: ceph
    MYSQL_ROOT_PASSWORD: "passwd"
backend:
  image: kairen/s3-api:latest
  container_name: backend
  links:
    - db:db
  environment:
    ACCESS_KEY: "<RADOSGW_ADMIN_ACCESS_KEY>"
    SECERT_KEY: "<RADOSGW_ADMIN_SECERT_KEY>"
    S3_URL: "<RADOSGW_S3_URL>"
    ADMIN_ENRTYPOINT: "<RADOSGW_ADMIN_ENRTYPOINT>"
  ports:
    - 8080:80
frontend:
  image: kairen/s3-ui:latest
  container_name: frontend
  environment:
    BACKEND_ADDRESS: "<S3_API_ADDRESS>"
  ports:
    - 80:3000

```
> **注意！** 這邊資料庫也可以透過設定`DB_HOST`方式來連接。

> **注意！** 這邊`S3_URL`為 radosgw s3 like URL, 必須以網域方式提供。

> **注意!** 這邊的`ACCESS_KEY`與`SECERT_KEY`的使用者必須擁有`caps`權限。可以透過以下方式建立：
```sh
$ radosgw-admin caps add --uid="<admin_uid>" --caps="users=*"
```
> 其他參數設定如下所示：
```
--caps="[users|buckets|metadata|usage|zone]=[*|read|write|read, write]"
```

確認檔案設定沒問題後，即可透過以下指令進行部署：
```sh
$ docker-compose up
```
> 若要放到背景可以加入`-d`參數。

若要停止服務，執行以下指令：
```sh
$ docker-compose stop
```

若要刪除服務，執行以下指令：
```sh
$ docker-compose rm -f
```

![snapshot](images/snapshot-ui.png)
