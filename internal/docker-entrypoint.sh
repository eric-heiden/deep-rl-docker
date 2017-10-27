#!/bin/bash

export USER=wal

# Add local user
# Either use the USER_UID if passed in at runtime or
# fallback

USER_ID=${USER_UID:-9001}

echo "Starting with UID: $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m $USER

# Clean up bashrc
echo "export USER=$USER" >> "/home/$USER/.bashrc"

echo "export HOME=/home/$USER" >> "/home/$USER/.bashrc"
export HOME=/home/$USER

echo "export \$(dbus-launch)" >> "/home/$USER/.bashrc"

cd "/home/$USER/"


# # echo "export PYTHONPATH=/opt/rllab:$PYTHONPATH" >> "/home/$USER/.bashrc"
# # export PYTHONPATH=/opt/rllab:$PYTHONPATH
# echo "export PYTHONPATH=/opt/rllab" >> "/home/$USER/.bashrc"
# echo "export PATH=/usr/local/cuda/bin:/opt/conda/bin:\$PATH" >> "/home/$USER/.bashrc"

# source "/home/$USER/.bashrc"


# jupyter lab --allow-root --ip=* --port=8888 --no-browser &

exec /usr/local/bin/gosu $USER "$@"
