# ssserver
FROM alpine:3.6

ENV AUTHPR "teachmyself@126.com"

ENV SERVER_ADDR="0.0.0.0" \
    SERVER_PORT="8888" \
    PASSWORD="123456" \
    METHOD="aes-256-cfb" \
    TIMEOUT="300" \
    WORKERS="6" \
    FORBIDDEN_IP="1.1.1.1,2.2.2.2" \
    MANAGE_ADDRESS="127.0.0.1"

RUN set -xue; \
		sed -i 's#^#\##g' /etc/apk/repositories; \
        sed -i '1ihttp://mirrors.ustc.edu.cn/alpine/v3.6/main/' /etc/apk/repositories; \
        sed -i '1ihttp://mirrors.ustc.edu.cn/alpine/v3.6/community/' /etc/apk/repositories; \
        sed -i '1ihttps://mirrors.tuna.tsinghua.edu.cn/alpine/v3.6/main/' /etc/apk/repositories; \
        sed -i '1ihttps://mirrors.tuna.tsinghua.edu.cn/alpine/v3.6/community/' /etc/apk/repositories; \
		apk update && apk add --no-cache \
            py-pip \
            && \
	    pip install pip --upgrade && \
            aliyun-ecs \
            shadowsocks \
            && \
        rm -rf /var/cache/apk/* ~/.cache/ /tmp/*

CMD ["sh", "-c", "ssserver -v -s ${SERVER_ADDR} -p ${SERVER_PORT} -k ${PASSWORD} -m ${METHOD} -t ${TIMEOUT} --workers ${WORKERS} --forbidden-ip ${FORBIDDEN_IP} --manager-address ${MANAGE_ADDRESS}"]
