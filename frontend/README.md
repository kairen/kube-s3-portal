# Ceph S3 Frontend
快速建置一個 Ceph S3 Frontend Server 可以透過以下指令進行部署：
```sh
$ docker run -d -p 80:80 --name frontend \
-e BACKEND_URL= "<backend_url>" \
imaccloud/s3-ui:0.1.0
```
