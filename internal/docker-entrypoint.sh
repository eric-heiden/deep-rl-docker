#!/bin/bash

# Add local user
# Either use the USER_UID if passed in at runtime or
# fallback
USER_ID=${USER_UID:-9001}

cd $HOME
touch .bashrc

echo "Starting with UID: $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m $USER

echo "export USER=$USER" >> "$HOME/.bashrc"
echo "export HOME=$HOME" >> "$HOME/.bashrc"

echo "export \$(dbus-launch)" >> "$HOME/.bashrc"
echo "export LD_LIBRARY_PATH=/external_libs:\$LD_LIBRARY_PATH" >> "$HOME/.bashrc"



# # echo "export PYTHONPATH=/opt/rllab:$PYTHONPATH" >> "/home/$USER/.bashrc"
# # export PYTHONPATH=/opt/rllab:$PYTHONPATH
# echo "export PYTHONPATH=/opt/rllab" >> "/home/$USER/.bashrc"
# echo "export PATH=/usr/local/cuda/bin:/opt/conda/bin:\$PATH" >> "/home/$USER/.bashrc"

# source "/home/$USER/.bashrc"


# jupyter lab --allow-root --ip=* --port=8888 --no-browser &

exec /usr/local/bin/gosu $USER "$@"
