#!/bin/bash

function rand(){
    start=$1
    end=$(($2-$start+1))
    num=$(cat /dev/urandom | head -n 10 | cksum | awk -F ' ' '{print $1}')
    echo $(($num%$end+$start))
}

PORT=$(rand 30000 65535)
IP=$(ip addr show | grep eth1 | grep inet | awk '{print $2}' | cut -d'/' -f1)
SERVICE_NAME=mesh-v2
DOCKER_NAME=$SERVICE_NAME-$(cat /dev/urandom | head -n 10 | md5sum | head -c 10)

docker run -d --network host --name $DOCKER_NAME -p $PORT:$PORT --env IP=$IP --env SERVICE_NAME=$SERVICE_NAME docker.io/zhanyang/helloworld:1.0 -addr :$PORT -text Mesh-V2

