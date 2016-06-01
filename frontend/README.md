# Ceph S3 Portal Frontend
若要建置映像檔的話，可以透過以下指令進行：
```sh
$ docker build -t imaccloud/s3-ui:0.1.1 .
```

快速部署一個 Ceph S3 Frontend Server 可以透過以下指令進行：
```sh
$ docker run -d -p 80:3000 --name frontend \
-e BACKEND_ADDRESS="<backend_address>" \
imaccloud/s3-ui:0.1.1
```
