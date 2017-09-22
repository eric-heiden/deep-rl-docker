#!/bin/bash

ORANGE='\033[0;33m'
WHITE='\033[1;37m'

export USER=wal

# Clean up bashrc
echo "export USER=wal" > "/home/$USER/.bashrc"

echo "export USER=$USER" >> "/home/$USER/.bashrc"
echo "export HOME=/home/$USER" >> "/home/$USER/.bashrc"
export HOME=/home/$USER

if [ ! -d "/home/$USER/catkin_ws/src" ]; then
	mkdir -p "/home/$USER/catkin_ws/src"
fi

cd "/home/$USER/"
# mkdir dev
# cd dev
# pushd .

# # Installs a CMake project from a git repository.
# # Args: rel_target_folder_name print_name repository_url
# function install_from_git {
# 	if [ ! -d "/home/$USER/dev/$1/build" ] && [ ! -f "/home/$USER/dev/$1/build" ]; then
# 		echo -e "${ORANGE}Building and installing $2.${WHITE}"
# 		git clone $3 $1 \
# 			&& cd $1 \
# 			&& mkdir build && cd build \
# 			&& cmake .. && make -j4 && make install
# 		popd
# 		pushd .
# 	else
# 		echo -e "${ORANGE}$2 already exists, just need to install.${WHITE}"
# 		cd "/home/$USER/dev/$1/build" && make install
# 		popd
# 		pushd .
# 	fi
# }

# # Installs a CMake project from a tar.gz archive.
# # Args: rel_target_folder_name print_name tar_url
# function install_from_targz {
# 	if [ ! -d "/home/$USER/dev/$1/build" ] && [ ! -f "/home/$USER/dev/$1/build" ]; then
# 		echo -e "${ORANGE}Building and installing $2.${WHITE}"
# 		wget -O $1.tar.gz $3 \
# 			&& tar xzf $1.tar.gz \
# 			&& rm $1.tar.gz \
# 			&& cd $1 \
# 			&& mkdir build && cd build \
# 			&& cmake .. && make -j4 && make install
# 		popd
# 		pushd .
# 	else
# 		echo -e "${ORANGE}$2 already exists, just need to install.${WHITE}"
# 		cd "/home/$USER/dev/$1/build" && make install
# 		popd
# 		pushd .
# 	fi
# }

# # Install VTK 7
# install_from_targz "VTK-7.1.1" "VTK 7.1.1" "http://www.vtk.org/files/release/7.1/VTK-7.1.1.tar.gz"
# # if [ ! -d "/home/$USER/dev/VTK-7.1.1/build" ] && [ ! -f "/home/$USER/dev/VTK-7.1.1/build" ]; then
# # 	echo -e "${ORANGE}Building and installing VTK 7.${WHITE}"
# # 	wget -O vtk.tar.gz \
# # 			http://www.vtk.org/files/release/7.1/VTK-7.1.1.tar.gz \
# # 		&& tar xzf vtk.tar.gz \
# # 		&& rm vtk.tar.gz \
# # 		&& cd VTK-7.1.1 \
# # 		&& mkdir build && cd build \
# # 		&& cmake .. && make -j4 && make install
# # 	popd
# # 	pushd .
# # else
# # 	echo -e "${ORANGE}VTK 7 already exists, just need to install.${WHITE}"
# # 	cd "/home/$USER/dev/VTK-7.1.1/build" && make install
# # 	popd
# # 	pushd .
# # fi

# # Install PCL 1.8
# install_from_targz "pcl-pcl-1.8.0" "PCL 1.8" "https://github.com/PointCloudLibrary/pcl/archive/pcl-1.8.0.tar.gz"
# # if [ ! -d "/home/$USER/dev/pcl-pcl-1.8.0/build" ] && [ ! -f "/home/$USER/dev/pcl-pcl-1.8.0/build" ]; then
# # 	echo -e "${ORANGE}Building and installing PCL.${WHITE}"
# # 	wget -O pcl.tar.gz \
# # 			https://github.com/PointCloudLibrary/pcl/archive/pcl-1.8.0.tar.gz \
# # 		&& tar xzf pcl.tar.gz \
# # 		&& rm pcl.tar.gz \
# # 		&& cd pcl-pcl-1.8.0 \
# # 		&& mkdir build && cd build \
# # 		&& cmake .. && make -j4 && make install
# # 	popd
# # 	pushd .
# # else
# # 	echo -e "${ORANGE}PCL already exists, just need to install.${WHITE}"
# # 	cd "/home/$USER/dev/pcl-pcl-1.8.0/build" && make install
# # 	popd
# # 	pushd .
# # fi

# # Install NLopt
# install_from_git "nlopt" "NLopt" "https://github.com/stevengj/nlopt.git"
# # if [ ! -d "/home/$USER/dev/nlopt/build" ] && [ ! -f "/home/$USER/dev/nlopt/build" ]; then
# # 	echo -e "${ORANGE}Building and installing NLopt.${WHITE}"
# # 	git clone https://github.com/stevengj/nlopt.git nlopt \
# # 		&& cd nlopt \
# # 		&& mkdir build && cd build \
# # 		&& cmake .. && make -j4 && make install
# # 	popd
# # 	pushd .
# # else
# # 	echo -e "${ORANGE}NLopt already exists, just need to install.${WHITE}"
# # 	cd "/home/$USER/dev/nlopt/build" && make install
# # 	popd
# # 	pushd .
# # fi

# # Install GLFW
# install_from_git "glfw" "GLFW" "https://github.com/glfw/glfw.git"
# # if [ ! -d "/home/$USER/dev/glfw/build" ] && [ ! -f "/home/$USER/dev/glfw/build" ]; then
# # 	echo -e "${ORANGE}Building and installing GLFW.${WHITE}"
# # 	git clone https://github.com/glfw/glfw.git glfw \
# # 		&& cd glfw \
# # 		&& mkdir build && cd build \
# # 		&& cmake .. && make -j4 && make install
# # 	popd
# # 	pushd .
# # else
# # 	echo -e "${ORANGE}GLFW already exists, just need to install.${WHITE}"
# # 	cd "/home/$USER/dev/glfw/build" && make install
# # 	popd
# # 	pushd .
# # fi

# # Install GLFWM
# install_from_git "glfwm" "GLFWM" "https://github.com/eric-heiden/glfwm.git"
# # if [ ! -d "/home/$USER/dev/glfwm/build" ] && [ ! -f "/home/$USER/dev/glfwm/build" ]; then
# # 	echo -e "${ORANGE}Building and installing GLFWM.${WHITE}"
# # 	git clone https://github.com/eric-heiden/glfwm.git glfwm \
# # 		&& cd glfwm \
# # 		&& mkdir build && cd build \
# # 		&& cmake .. && make -j4 && make install
# # 	popd
# # 	pushd .
# # else
# # 	echo -e "${ORANGE}GLFWM already exists, just need to install.${WHITE}"
# # 	cd "/home/$USER/dev/glfwm/build" && make install
# # 	popd
# # 	pushd .
# # fi



# # git clone https://github.com/jbohren-forks/sophus.git sophus
# # cd sophus && mkdir build && cd build && cmake .. && make && make install
# # we have to rename "Sophus..." to "sophus..." so that CMake can find it
# # mv "/home/$USER/dev/sophus/build/SophusConfig.cmake" "/home/$USER/dev/sophus/build/sophusConfig.cmake"
# # export sophus_DIR="/home/$USER/dev/sophus/build"
# export CMAKE_PREFIX_PATH=/usr/local:$CMAKE_PREFIX_PATH

# cd "/home/$USER/catkin_ws/src"
# echo -e "${ORANGE}Retrieving ECL dependencies.${WHITE}"
# mkdir ecl
# cd ecl
# git clone https://github.com/stonier/ecl_tools.git
# git clone https://github.com/stonier/ecl_core.git
# git clone https://github.com/stonier/ecl_lite.git
# git clone https://github.com/stonier/ecl_manipulation.git
# git clone https://github.com/stonier/ecl_navigation.git
# git clone https://github.com/strasdat/Sophus.git

# cd "/home/$USER/catkin_ws"
# echo -e "${ORANGE}Resolving dependencies.${WHITE}"
# rosdep update
# rosdep install --from-paths src -y -i --ignore-src

# echo -e "${ORANGE}Building catkin work space.${WHITE}"
# catkin_make && source devel/setup.bash
# echo "source /home/$USER/catkin_ws/devel/setup.bash" >> "/home/$USER/.bashrc"

# # echo "export PYTHONPATH=/opt/rllab:$PYTHONPATH" >> "/home/$USER/.bashrc"
# # export PYTHONPATH=/opt/rllab:$PYTHONPATH
# echo "export PYTHONPATH=/opt/rllab" >> "/home/$USER/.bashrc"
# echo "export PATH=/usr/local/cuda/bin:/opt/conda/bin:\$PATH" >> "/home/$USER/.bashrc"

# echo -e "${ORANGE}Installed rllab in /opt/rllab."
# echo -e "${ORANGE}Run \"source activate rllab3\" to start.${WHITE}"

# source "/home/$USER/.bashrc"


# jupyter lab --allow-root --ip=* --port=8888 --no-browser &

# mkdir -p /root/.config/terminator
# cp /terminator_layout /root/.config/terminator/config

# nohup terminator </dev/null &>/dev/null &
# terminator </dev/null &>/dev/null &
bash
