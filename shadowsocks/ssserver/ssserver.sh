#!/usr/bin/env bash
#
#

#set -x
#set -u
#set -e

# Default Options
NAME="ssserver"
PORT="8888"
PASSWORD="123456"
METHOD="aes-256-cfb"

red() {
    echo -e "\033[31;5m${@}\033[0m"
}
green() {
    echo -e "\033[32;5m${@}\033[0m"
}
msg() {
    echo "[$(date '+%F %T%z')] ${@}"
}

help() {
    echo "Usage: $0 [-i|-s|-S]"
    echo "    -h    display this help and exit."
    echo "    -i    install and start docker."
    echo "    -s    pull teachmyself/ssserver and start a container."
    echo "    -p    specified port, should be used with -s option."
    echo "    -S    stop ssserver container."
    echo "    -r    remove ssserver container."
    echo "    -a    show docker status and list all containers on the host."
    echo "    -x    show detail information."
    echo "Optional:"
    echo "    -n name     specified container name, default ssserver."
    echo "    -p port     specified container port mapped, default is 8888."
    echo "    -m method   specified encryption method, default aes-256-cfb."
    echo "    -P password specified containername default is 123456"
    echo "Example:"
    echo "    $0 -i	          # install docker"
    echo "    $0 -is	          # install and start docker"
    echo "    $0 -s	          # start a container"
    echo "    $0 -S	          # stop ssserver container"
    echo "    $0 -r               # stop and remove ssserver container"
    echo ""
    echo "    $0 -p 6666 -s"	# start container with port 6666
    echo "    $0 -n test -p 6666 -P 123654 -m aes-256-cfb -s   # start contianer with options."
    echo "    $0 -n test -S   # stop container named ssserver"
}

docker_install() {
    if [[ "$(uname -s)" == "Linux" ]]; then
        msg "$(green 'Installing docker')"
        [[ "$(lsb_release -si)" == "CentOS" ]] && sudo yum -y install docker
        [[ "$(lsb_release -si)" == "Ubuntu" ]] && sudo apt-get -y install docker
        service docker start
        systemctl enable docker
    fi
}
docker_all() {
    [[ "$(uname -s)" == "Linux" ]] && systemctl status docker
    docker ps -a
}
docker_start() {
    msg "$(green 'Starting container with command blow:')"
    set -x
    docker run -d  \
        -e SERVER_PORT=${PORT} \
        -e PASSWORD=${PASSWORD} \
        -e METHOD=${METHOD} \
        -p ${PORT}:${PORT} \
        --name ${NAME} \
        --restart always \
        teachmyself/ssserver
    set +x
    docker_all
}
docker_stop() {
    msg "$(green 'Stopping container')"
    docker stop ${NAME} -t 0 
}
docker_remove() {
    docker_stop
    msg "$(green 'Removing container')" 
    docker rm ${NAME}
}

process_args() {
    while getopts :hn:p:P:m:isSrax opt
    do
        case "${opt}" in
            h) help && exit 0 ;;
            x) set -x ;;
            n) NAME="${OPTARG}" ;;
            p) PORT="${OPTARG}" ;;
            P) PASSWORD="${OPTARG}" ;;
            m) METHOD="${OPTARG}" ;;
            i) docker_install ;;
            s) docker_start && exit $? ;;
            S) docker_stop && exit $? ;;
            r) docker_remove && exit $? ;;
            a) docker_all && exit $? ;;
            \?) msg "Error: illegal option -- ${OPTARG}" ;;
            :) msg "Error: Option -${OPTARG} requires on argument." ;;
            "") help && exit 1 ;;
        esac
    done

    shift "$(( ${OPTIND} - 1 ))"

    [[ "${@}" == "" ]] && help && exit 1
}

process_args "${@}"
