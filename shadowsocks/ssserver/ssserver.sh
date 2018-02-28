#!/usr/bin/env bash
#
#

PORT="16100"
PASSWORD="123654"
METHOD="aes-256-cfb"
NAME="ssserver"


msg() {
    echo "[$(date '+%F %T%z')] ${@}"
}

help() {
    echo ""
    echo "Usage: $0 [install|start|stop|remove|restart]"
    echo "Example:"
    echo "	$0 install"
    echo "	$0 start"
    echo "	$0 stop"
    echo "	$0 remove"
    echo "	$0 restart"
    echo ""
}
docker_install() {
    sudo apt-get -y install docker   
    service docker start
    update-rc.d -f docker defaults
}
docker_start() {
    docker pull teachmyself/ssserver
    docker run -d  \
        -e SERVER_PORT=${PORT} \
        -e PASSWORD=${PASSWORD} \
        -e METHOD=${METHOD} \
        -p ${PORT}:${PORT} \
        --name ${NAME} \
        --restart always \
        teachmyself/ssserver
}
docker_stop() {
    docker stop ${NAME}
}
docker_status() {
    docker ps -a
}
docker_rm() {
    docker rm ${NAME}
}
docker_restart() {
    docker_stop
    docker_rm
    docker_start
}

if [[ "${@}" == "" ]]; then
    help
else
    docker_$1
fi
