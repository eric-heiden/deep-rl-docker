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
	--volume=$XSOCK:$XSOCK:rw \
	--volume=$XAUTH:$XAUTH:rw \
	--volume=/dev/bus/usb:/dev/bus/usb \
	--env="XAUTHORITY=${XAUTH}" \
	--env="USER_UID=${USER_UID}" \
	--env="USER_GID=${USER_GID}" \
	--env="DISPLAY=${DISPLAY}" \
	--privileged=true \
	-p 6006:6006 \
	-p 8888:8888 \
	uscresl/deep-rl-docker:tf1.3.0-gym0.9.3-baselines0.1.4-py3 \
	bash