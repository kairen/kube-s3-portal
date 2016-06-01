# Dockerize Ceph S3 Portal
本專案說明如何透過 Dockerfile 部署 Ceph S3 Portal 前端與後端服務，目前已提供 Docker Compose 來快速建置。

### Quick Start
透過 docker-compose 執行的話，請修改```docker-compose.yml```檔案，然後修改以下內容：
```yaml
db:
  image: mysql:5.6
  container_name: db
  environment:
    MYSQL_DATABASE: ceph
    MYSQL_ROOT_PASSWORD: r00tme
backend:
  image: imaccloud/s3-api:0.1.1
  container_name: backend
  links:
    - db:db
  environment:
    ACCESS_KEY: "<access_key>"
    SECERT_KEY: "<secert_key>"
    S3_URL: "<radosgw_s3_url>"
    ADMIN_ENRTYPOINT: "<radosgw_admin_entrypoint>"
  ports:
    - 8080:80
frontend:
  image: imaccloud/s3-ui:0.1.1
  container_name: frontend
  environment:
    BACKEND_ADDRESS: "192.168.99.100:8080"
  ports:
    - 80:3000
```
> **注意！** 這邊資料庫也可以透過設定 ```DB_HOST``` 方式來連接。

> **注意！** 這邊```S3_URL```為 radosgw s3 like URL, 必須以網域方式提供。

> **注意!** 這邊的```ACCESS_KEY```與```SECERT_KEY```必須是擁有```caps```權限的使用者。可以透過以下方式建立：
```sh
$ radosgw-admin caps add --uid="<admin_uid>" --caps="users=*"
```
> 其他參數設定如下所示：
```
--caps="[users|buckets|metadata|usage|zone]=[*|read|write|read, write]"
```

確認檔案設定沒問題後，即可透過以下指令進行部署：
```sh
$ docker-compse up
```
> 若要放到背景可以加入```-d```參數。

![snapshot](images/snapshot-ui.png)
