# Create Ceph on Docker
First, Create a Docker bridge network provide to Ceph：
```sh
$ docker network create --driver bridge cluster-net
$ docker network inspect cluster-net
{
    "Subnet": "172.18.0.0/16",
    "Gateway": "172.18.0.1/16"
}
```

And then run `compose` to create a Ceph cluster:
```sh
$ docker-compose up
```
