#!/bin/sh

USER_UID=$(id -u)
USER_GID=$(id -g)
# XSOCK=/tmp/.X11-unix
# XAUTH=/tmp/.docker.xauth
# touch $XAUTH
# xauth -b nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -b -f $XAUTH nmerge -
xhost +local:root

# variable with all the needed values for libgl and to be accessed through LD_LIBRARY_PATH
DOCKER_VISUAL_NVIDIA="-e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/nvidia0 --device /dev/nvidiactl -v /usr/lib/x86_64-linux-gnu/libXau.so.6.0.0:/external_libs/libXau.so.6.0.0 -v /usr/lib/x86_64-linux-gnu/libXdmcp.so.6:/external_libs/libXdmcp.so.6 -v /usr/lib/x86_64-linux-gnu/libXext.so.6:/external_libs/libXext.so.6 -v /usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0:/external_libs/libXdmcp.so.6.0.0 -v /usr/lib/x86_64-linux-gnu/libX11.so.6.3.0:/external_libs/libX11.so.6.3.0 -v /usr/lib/x86_64-linux-gnu/libxcb.so.1:/external_libs/libxcb.so.1 -v /usr/lib/nvidia-375/libGL.so.375.66:/external_libs/libGL.so.375.66 -v /usr/lib/nvidia-375/libnvidia-glcore.so.375.66:/external_libs/libnvidia-glcore.so.375.66 -v /usr/lib/nvidia-375/libGL.so.1:/external_libs/libGL.so.1 -v /usr/lib/x86_64-linux-gnu/libXext.so.6.4.0:/external_libs/libXext.so.6.4.0 -v /usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0:/external_libs/libxcb.so.1.1.0 -v /usr/lib/x86_64-linux-gnu/libX11.so.6:/external_libs/libX11.so.6 -v /usr/lib/x86_64-linux-gnu/libXau.so.6:/external_libs/libXau.so.6 -v /usr/lib/nvidia-375/tls/libnvidia-tls.so.375.66:/external_libs/libnvidia-tls.so.375.66"
# run the program
# docker run --rm $DOCKER_VISUAL_NVIDIA -e QT_X11_NO_MITSHM=1 -v $HOME/.ros:$HOME/.ros:rw -v $HOME/.gazebo:$HOME/.gazebo:rw osrf/ros:kinetic-desktop-full roslaunch gazebo_ros empty_world.launch

nvidia-docker run \
	-it \
	--rm $DOCKER_VISUAL_NVIDIA -e QT_X11_NO_MITSHM=1 \
	--volume=/home/:/home/:rw \
	--volume=/root/:/root/:rw \
	--env="USER_UID=${USER_UID}" \
	--env="USER_GID=${USER_GID}" \
	--env="USER=${USER}" \
	--env="DISPLAY" \
	--privileged=true \
	uscresl/deep-rl-docker:tf1.3.0-gym0.9.3-baselines0.1.4-gpu-py3 \
	bash
xhost -local:root