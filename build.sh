#!/bin/bash
mkdir -p $HOME/.deep-rl-docker

device=${1:-"cpu"}

if [ "$device" = "gpu" ] ; then
	echo "Building GPU version of deep-rl-docker..." ;
	nvidia-docker build -f Dockerfile.gpu \
		-t uscresl/deep-rl-docker:tf1.8.0-gym0.10.3-gpu-py3 \
		--build-arg USER=$USER \
		--build-arg HOME=$HOME/.deep-rl-docker . ;
else
	echo "Building CPU version of deep-rl-docker..." ;
	docker build -f Dockerfile \
		-t uscresl/deep-rl-docker:tf1.8.0-gym0.10.3-py3 \
		--build-arg USER=$USER \
		--build-arg HOME=$HOME/.deep-rl-docker . ;
fi