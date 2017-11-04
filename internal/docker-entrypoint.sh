#!/bin/bash

# Add local user
# Either use the USER_UID if passed in at runtime or
# fallback
USER_ID=${USER_UID:-9001}

export HOME=$DOCKER_HOME

sudo chmod -R 777 $DOCKER_HOME

cd $DOCKER_HOME
touch .bashrc

echo "Starting with UID: $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m $USER

echo "export USER=$USER" > "$DOCKER_HOME/.bashrc"
echo "export HOME=$DOCKER_HOME" >> "$DOCKER_HOME/.bashrc"

echo "export \$(dbus-launch)" >> "$DOCKER_HOME/.bashrc"
echo "export LD_LIBRARY_PATH=/external_libs:\$LD_LIBRARY_PATH" >> "$DOCKER_HOME/.bashrc"

if [ -f "/opt/mujoco/mjkey.txt" ]; \
then \
    echo "export MUJOCO_PY_MJPRO_PATH=/opt/mujoco/mjpro131" >> "$DOCKER_HOME/.bashrc"
	echo "export MUJOCO_LICENSE_KEY=/opt/mujoco/mjkey.txt" >> "$DOCKER_HOME/.bashrc"
	echo "export MUJOCO_PY_MUJOCO_PATH=/opt/mujoco" >> "$DOCKER_HOME/.bashrc"
	echo "export MUJOCO_PY_MJKEY_PATH=/opt/mujoco/mjkey.txt" >> "$DOCKER_HOME/.bashrc"
	echo "export LD_LIBRARY_PATH=/opt/mujoco/mjpro150/bin:\$LD_LIBRARY_PATH" >> "$DOCKER_HOME/.bashrc"
else \
    echo "Please manually copy your MoJoCo key file (mjkey.txt) to ~/.mujoco when inside the docker container." 1>&2 ; \
fi


# # echo "export PYTHONPATH=/opt/rllab:$PYTHONPATH" >> "/home/$USER/.bashrc"
# # export PYTHONPATH=/opt/rllab:$PYTHONPATH
# echo "export PYTHONPATH=/opt/rllab" >> "/home/$USER/.bashrc"
# echo "export PATH=/usr/local/cuda/bin:/opt/conda/bin:\$PATH" >> "/home/$USER/.bashrc"

# source "/home/$USER/.bashrc"


# jupyter lab --allow-root --ip=* --port=8888 --no-browser &

exec /usr/local/bin/gosu $USER bash --rcfile $DOCKER_HOME/.bashrc
