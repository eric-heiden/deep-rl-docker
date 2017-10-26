#!/bin/sh

USER_UID=$(id -u)
USER_GID=$(id -g)
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth -b nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -b -f $XAUTH nmerge -

docker run \
	-it \
	--volume=/home/:/home/:rw \
	--volume=/Users/:/Users/:rw \
	--volume=$XSOCK:$XSOCK:rw \
	--volume=$XAUTH:$XAUTH:rw \
	--env="XAUTHORITY=${XAUTH}" \
	--env="USER_UID=${USER_UID}" \
	--env="USER_GID=${USER_GID}" \
	--env="DISPLAY=${DISPLAY}" \
	-p 6006:6006 \
	-p 8888:8888 \
	uscresl/deep-rl-docker:tf1.4.0rc1-gym0.9.4-py3 \
	terminator
