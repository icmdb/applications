# bitcoin

[TOC]

## Build

```bash
docker build --rm -t tt .
```

## Run

```bash
docker run --rm -d \
    --name bitcoind \
    -p 8333:8333 \
    -p 8332:8332 \
    tt
```
