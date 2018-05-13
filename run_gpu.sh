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
	NVIDIA_DRIVER=$(nvidia-settings -q NvidiaDriverVersion | head -2 | tail -1 | sed 's/.*\([0-9][0-9][0-9]\)\..*/\1/') ;
fi
if [ -z ${NVIDIA_DRIVER+x} ]; then
	echo "Error: Could not determine NVIDIA driver version number. Please specify your driver version number manually in $0." 1>&2 ;
	exit ;
else
	echo "Linking to NVIDIA driver version $NVIDIA_DRIVER..." ;
fi



# variable with all the needed values for libgl and to be accessed through LD_LIBRARY_PATH
DOCKER_VISUAL_NVIDIA="-v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/nvidia0 --device /dev/nvidiactl"
# run the program
# docker run --rm $DOCKER_VISUAL_NVIDIA -e QT_X11_NO_MITSHM=1 " \
# "-v $HOME/.ros:$HOME/.ros:rw -v $HOME/.gazebo:$HOME/.gazebo:rw osrf/ros:kinetic-desktop-full roslaunch gazebo_ros empty_world.launch

nvidia-docker run \
	-it \
	--init \
	$DOCKER_VISUAL_NVIDIA \
	--volume=/home/:/home/:rw \
	--volume=/media/:/media/:rw \
	--env="USER_UID=${USER_UID}" \
	--env="USER_GID=${USER_GID}" \
	--env="USER=${USER}" \
	--env="HOME=${HOME}/.deep-rl-docker" \
	--env="DISPLAY" \
	-p 6006:6006 \
	-p 8888:8888 \
	--cap-add SYS_ADMIN \
	--cap-add MKNOD \
	--device /dev/fuse \
	--security-opt apparmor:unconfined \
	--name "deep-rl-docker" \
	uscresl/deep-rl-docker:tf1.8.0-gym0.10.3-gpu-py3
xhost -local:root
