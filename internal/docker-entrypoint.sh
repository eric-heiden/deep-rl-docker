#!/bin/bash

export USER=wal

# Clean up bashrc
echo "export USER=wal" > "/home/$USER/.bashrc"

echo "export USER=$USER" >> "/home/$USER/.bashrc"
echo "export HOME=/home/$USER" >> "/home/$USER/.bashrc"
export HOME=/home/$USER

cd "/home/$USER/"


# # echo "export PYTHONPATH=/opt/rllab:$PYTHONPATH" >> "/home/$USER/.bashrc"
# # export PYTHONPATH=/opt/rllab:$PYTHONPATH
# echo "export PYTHONPATH=/opt/rllab" >> "/home/$USER/.bashrc"
# echo "export PATH=/usr/local/cuda/bin:/opt/conda/bin:\$PATH" >> "/home/$USER/.bashrc"

# source "/home/$USER/.bashrc"


# jupyter lab --allow-root --ip=* --port=8888 --no-browser &

bash
