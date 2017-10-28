#!/bin/sh

USER_UID=$(id -u)
USER_GID=$(id -g)
# XSOCK=/tmp/.X11-unix
# XAUTH=/tmp/.docker.xauth
# touch $XAUTH
# xauth -b nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -b -f $XAUTH nmerge -
xhost +local:root

# Manually set NVIDIA driver version number
# NVIDIA_DRIVER=375

if [ -z ${NVIDIA_DRIVER+x} ]; then
	NVIDIA_DRIVER=$(nvidia-settings -q NvidiaDriverVersion | head -2 | tail -1 | sed 's/.*\([0-9][0-9][0-9]\).*/\1/') ;
fi
if [ -z ${NVIDIA_DRIVER+x} ]; then
	echo "Error: Could not determine NVIDIA driver version number. Please specify your driver version number manually in $0." 1>&2 ;
	exit ;
else
	echo "Linking to NVIDIA driver version $NVIDIA_DRIVER..." ;
fi



# variable with all the needed values for libgl and to be accessed through LD_LIBRARY_PATH
DOCKER_VISUAL_NVIDIA="-e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/nvidia0 --device /dev/nvidiactl -v /usr/lib/x86_64-linux-gnu/libXau.so.6.0.0:/external_libs/libXau.so.6.0.0 -v /usr/lib/x86_64-linux-gnu/libXdmcp.so.6:/external_libs/libXdmcp.so.6 -v /usr/lib/x86_64-linux-gnu/libXext.so.6:/external_libs/libXext.so.6 -v /usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0:/external_libs/libXdmcp.so.6.0.0 -v /usr/lib/x86_64-linux-gnu/libX11.so.6.3.0:/external_libs/libX11.so.6.3.0 -v /usr/lib/x86_64-linux-gnu/libxcb.so.1:/external_libs/libxcb.so.1 -v /usr/lib/nvidia-$NVIDIA_DRIVER/:/external_libs/"
# run the program
# docker run --rm $DOCKER_VISUAL_NVIDIA -e QT_X11_NO_MITSHM=1 -v $HOME/.ros:$HOME/.ros:rw -v $HOME/.gazebo:$HOME/.gazebo:rw osrf/ros:kinetic-desktop-full roslaunch gazebo_ros empty_world.launch

nvidia-docker run \
	-it \
	--rm \
	$DOCKER_VISUAL_NVIDIA \
	--volume=/home/:/home/:rw \
	--env="USER_UID=${USER_UID}" \
	--env="USER_GID=${USER_GID}" \
	--env="USER=${USER}" \
	--env="DISPLAY" \
	-p 6006:6006 \
	-p 8888:8888 \
	--cap-add SYS_ADMIN \
	--cap-add MKNOD \
	--device /dev/fuse \
	--security-opt apparmor:unconfined \
	uscresl/deep-rl-docker:tf1.4.0rc1-gym0.9.4-gpu-py3 \
	bash
xhost -local:root
