#!/bin/zsh

MOV=${1:-./demo.mov}

echo $MOV

xhost + "$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')"
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
docker build --tag bgsub .
docker run -v $1:/app/demo.mov -e DISPLAY="$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')":0 --rm bgsub
