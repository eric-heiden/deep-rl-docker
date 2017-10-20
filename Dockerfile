FROM tensorflow/tensorflow:1.3.0-py3
MAINTAINER USC RESL <heiden@usc.edu>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 USER=wal HOME=/home/wal

RUN apt-get update && apt-get install -y \
        sudo \
        git \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install dependencies
RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        nano \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        git \
        python \
        python-pip \
        python-numpy \
        python-dev \
        python-opengl \
        cmake \
        zlib1g-dev \
        libjpeg-dev \
        xvfb \
        libav-tools \
        xorg-dev \
        libboost-all-dev \
        libsdl2-dev \
        swig \
        libgtk2.0-dev \
        wget \
        unzip \
        aptitude \
        pkg-config \
        qtbase5-dev \
        libqt5opengl5-dev \
        libassimp-dev \
        libpython3.5-dev \
        libboost-python-dev \
        libtinyxml-dev \
        libffi-dev \
        golang \
        python-opencv

RUN pip3 --no-cache-dir install \
    gym[all]==0.9.3 \
    scikit-image \
    plotly \
    ipykernel \
    jupyter \
    jupyterlab \
    matplotlib \
    numpy \
    scipy \
    sklearn \
    pandas \
    Pillow \
    empy \
    tqdm \
    pyopengl \
    opencv-python \
    theano \
    mujoco_py==0.5.7 \
    h5py \
    tables

RUN pip2 --no-cache-dir install \
    gym[all]==0.9.3 \
    scikit-image \
    plotly \
    ipykernel \
    jupyter \
    jupyterlab \
    matplotlib \
    numpy \
    scipy \
    sklearn \
    pandas \
    Pillow \
    empy \
    tqdm \
    pyopengl \
    opencv-python \
    theano \
    mujoco_py==0.5.7 \
    h5py \
    tables

# Install Jupyter Lab
RUN jupyter serverextension enable --py jupyterlab --sys-prefix

# Install Baselines
RUN cd /opt && git clone https://github.com/openai/baselines.git && cd baselines && pip install -e .

# Install Roboschool
ENV ROBOSCHOOL_PATH=/opt/roboschool
RUN git clone https://github.com/openai/roboschool.git /opt/roboschool
RUN cd /opt && git clone https://github.com/olegklimov/bullet3 -b roboschool_self_collision \
    && mkdir bullet3/build \
    && cd    bullet3/build \
    && cmake -DBUILD_SHARED_LIBS=ON -DUSE_DOUBLE_PRECISION=1 -DCMAKE_INSTALL_PREFIX:PATH=$ROBOSCHOOL_PATH/roboschool/cpp-household/bullet_local_install -DBUILD_CPU_DEMOS=OFF -DBUILD_BULLET2_DEMOS=OFF -DBUILD_EXTRAS=OFF  -DBUILD_UNIT_TESTS=OFF -DBUILD_CLSOCKET=OFF -DBUILD_ENET=OFF -DBUILD_OPENGL3_DEMOS=OFF .. \
    && make -j4 \
    && make install
RUN pip3 install -e /opt/roboschool

COPY ./internal/ /

# install VirtualGL
RUN dpkg -i /virtualgl_2.5.2_amd64.deb && rm /virtualgl_2.5.2_amd64.deb

# TensorBoard
EXPOSE 6006

# Jupyter
EXPOSE 8888

ENTRYPOINT ["/docker-entrypoint.sh"]
