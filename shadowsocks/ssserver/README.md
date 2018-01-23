# ssserver

> This mirror is only for technical study and research, please strictly abide by relevant laws and regulations, is strictly prohibited for commercial thoroughfare, do not browse or disseminate illegal information.


## Use Docker
### Installing Docker
```bash
# CentOS ( 7.x is Recommended)
yum -y install docker

# Ubuntu (16.04 is Recommended)
apt-get -y install docker
```


### Start Docker & Check status
```bash
service docker start
service docker status
```


### Pulling/Updating image & List images
```
docker pull teachmyself/ssserver
docker images
```


### Start ssserver
> You can change the value of  `SERVER_PORT`, `PASSWORD`, `METHOD` in the command before you run it.

```
docker run -d  \
    -v /etc/localtime:/etc/localtime:ro \
    -e SERVER_PORT=8888 \
    -e PASSWORD=123456 \
    -e METHOD=aes-256-cfb \
    -p 8888:8888 \
    --name ssserver \
    --restart always \
    teachmyself/ssserver
```


### List Containers
```bash
docker ps
```


### Check Logs of ssserver
```bash
docker logs ssserver
```


### Stop ssserver
```bash
docker stop ssserver
```


### Restart ssserver
```bash
docker restart ssserver
```


### Remove ssserver
```bash
docker rm ssserver
```


### docker-compose.yml
```bash
TODO:
```


## Use Composefile

### Standard Compose

@TODO

### Compose for Aliyun Container Service

[acs-compose.yml](acs-compose.yml)

