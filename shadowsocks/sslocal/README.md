# sslocal

[TOC]

> This image is only for technical study and research, please strictly abide by relevant laws and regulations, is strictly prohibited for commercial thoroughfare, do not browse or disseminate illegal information.

## Pull image
```bash
docker pull teachmyself/sslocal
docker images | grep sslocal
```

## Start container named sslocal

> This step depedends on a ssserver. You should change the value of `SERVER_HOST`, `SERVER_PORT`, `PASSWORD`, `METHOD` in the command before you run it.

```bash
docker run -d  \
    -e SERVER_HOST=1.1.1.1 \
    -e SERVER_PORT=8888 \
    -e PASSWORD=123456 \
    -e METHOD=aes-256-cfb \
    -p 8118:8118 \
    --name sslocal \
    --restart always \
    teachmyself/sslocal
```

## Check sslocal container
```bash
docker ps
```

## Check logs
```bash
docker exec sslocal tail -f /var/log/sslocal.log
```

## Stop & Remove sslocal
```bash
docker stop sslocal

docker rm sslocal
```

## Proxy Usage
```bash
export http_proxy=127.0.0.1:8118;
export https_proxy=127.0.0.1:8118;

curl www.google.com
```

