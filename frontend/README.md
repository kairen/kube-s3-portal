# inwinStack Ceph S3 Portal UI
本專案將 Ceph S3 Portal UI 建置為 Docker 容器應用程式。若要建立映像檔，可以透過以下指令進行：
```sh
$ docker build -t imaccloud/s3-ui:latest .
```

# Quick Start
目前已經有建立最新版本的 Ceph S3 Portal UI 於 [DockerHub](https://hub.docker.com/r/imaccloud/s3-ui/)。

想快速進行部署可以透過以下指令進行：
```sh
$ docker run -d -p 80:3000 --name frontend \
-e BACKEND_ADDRESS="<backend_address>" \
imaccloud/s3-ui:latest
```
> * ```BACKEND_ADDRESS```輸入 S3 Portal API 的 Domain name。

> * 其中 Port ```3000``` 為 S3 UI，```3001```為 Browser sync。
