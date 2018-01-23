# sslocal


## Example

```bash
docker run -d  \
    -e SERVER_HOST=1.1.1.1 \
    -e SERVER_PORT=8888 \
    -e PASSWORD=123456 \
    -e METHOD=aes-256-cfb \
    -e LOCAL_PORT=1080 \
    -e PROXY_PORT=8118 \
    -p 8118:8118 \
    --name sslocal \
    --restart always \
    teachmyself/sslocal
```

```
docker ps

docker logs sslocal

docker stop sslocal

docker rm sslocal

export http_proxy=127.0.0.1:8118;
export https_proxy=127.0.0.1:8118;
curl www.google.com
```



