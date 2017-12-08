#!/bin/bash

function rand(){
    start=$1
    end=$(($2-$start+1))
    num=$(cat /dev/urandom | head -n 10 | cksum | awk -F ' ' '{print $1}')
    echo $(($num%$end+$start))
}
