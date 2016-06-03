# Dockerize Ceph radosgw
Refer: https://github.com/ceph/ceph-docker
(TBD...)

首先建立一個 Docker Network：
```sh
$ docker network create --driver bridge cluster-net
$ docker network inspect cluster-net
{
    "Subnet": "172.18.0.0/16",
    "Gateway": "172.18.0.1/16"
}
```

然後建立一個 mon 容器：
```sh
$ DIR=$(pwd)
$ sudo docker run --net=cluster-net \
-v ${DIR}/ceph:/etc/ceph \
-v ${DIR}/lib/ceph/:/var/lib/ceph/ \
-e MON_IP=172.18.0.2 \
-e CEPH_PUBLIC_NETWORK=172.18.0.0/16 \
ceph/daemon mon
```
> 若發生問題請刪除以下目錄。如以下指令：
```sh
$ sudo rm -rf /etc/ceph/
$ sudo rm -rf /var/lib/ceph/
```

接著建立 osd 容器 Without OSD_TYPE：
```sh
$ sudo docker run -d --net=cluster-net \
--pid=host \
--privileged=true \
-v ${DIR}/ceph:/etc/ceph \
-v ${DIR}/lib/ceph/:/var/lib/ceph/ \
-v /dev/:/dev/ \
-e OSD_DEVICE=/dev/vdb \
-e OSD_FORCE_ZAP=1 \
--name osd1 \
ceph/daemon osd
```

建立一個 disk type 的 osd 容器：
```sh
$ sudo docker run -d --net=cluster-net \
--privileged=true \
--pid=host \
-v ${DIR}/ceph:/etc/ceph \
-v ${DIR}/lib/ceph/:/var/lib/ceph/ \
-v /dev/:/dev/ \
-e OSD_DEVICE=/dev/vdc \
-e OSD_TYPE=disk \
-e OSD_FORCE_ZAP=1 \
--name osd2 \
ceph/daemon osd
```

建立一個 msd 容器：
```sh
$ sudo docker run -d --net=cluster-net \
-v ${DIR}/lib/ceph/:/var/lib/ceph/ \
-v ${DIR}/ceph:/etc/ceph \
-e CEPHFS_CREATE=1 \
--name mds1 \
ceph/daemon mds
```

建立一個 rgw 容器：
```sh
$ sudo docker run -d --net=cluster-net \
-v ${DIR}/lib/ceph/:/var/lib/ceph/ \
-v ${DIR}/ceph:/etc/ceph \
-p 8080:8080 \
--name rgw1 \
ceph/daemon rgw
```
