# deep-rl-docker :whale: :robot:
Docker image with OpenAI Gym, Baselines, MuJoCo and Roboschool, utilizing TensorFlow and JupyterLab.

![Roboschool](https://github.com/eric-heiden/deep-rl-docker/blob/doc/roboschool.png?raw=true)

## Build
MoJoCo 1.50 and 1.31 will be installed under `.mujoco` in the container's home directory. Provide your MuJoCo key file (`mjkey.txt`) in the directory `internal` so that it can be placed at the required locations of the MuJoCo installations. At the moment, only institutional licenses are supported.

Dependent on the device version (CPU-only or NVIDIA GPU support), build the container as follows:
```bash
./build.sh [cpu|gpu]
```
If no first argument for device type is provided the CPU version will be installed.

When using the GPU version, make sure the [NVIDIA requirements](https://www.tensorflow.org/install/install_linux#NVIDIARequirements) to run TensorFlow with GPU support are satisfied. It helps to follow NVIDIA's [cuDNN installation guide](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html).

## Run
Execute `run.sh` or `run_gpu.sh`. This will run the container in foreground mode, i.e. its console becomes attached to the process’s standard input, output, and standard error.

*All RL-related dependencies (Roboschool, Gym, etc.) are available from within the python3 environment.*

Jupyter Lab will be published on port 8888. If you run TensorBoard it will be accessible on port 6006. Ports are tunneled through to your host system and can be reconfigured in `run.sh` or `run_gpu.sh`.

The container will install its home directory under `$HOME/.deep-rl-docker` on the host system via a shared volume. The docker's user has the same user identifier (UID) as the host system's user running the container to ensure file permissions are set up correctly in the shared volumes.

### Running deep-rl-docker on OSX with visualizations
Currently we do not have a solution to run the *deep-rl-docker* on OSX with visualizations in roboschool due to OpenGL problems. A workaround using Oracle VirtualBox that works with Virtual Machines (VMs) is listed below:

1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. In VirtualBox, create a VM for *Linux, Ubuntu (64-bit)* with the following settings:
	- Memory size: 5 GB+ 
	- Hard drive: *Create a virtual hard disk*, check *VDI*, check *Fixed size*, assign 20 GB+
	- Select your new VM in VirtualBox, and press the *Settings* icon
	- Under *Display*: Video Memory: maximum (128 MB), check *Enable 3D Acceleration*, 
3. Download [Ubuntu](https://www.ubuntu.com/download/desktop) and install it in the virtual machine you created in the previous step.
4. Follow [this guide](https://www.linuxbabe.com/virtualbox/speed-up-ubuntu-virtualbox) to install *VirtualBox Guest Additions* for Linux.
5. Execute the following command to install *CompizConfig Settings Manager*:
```bash
sudo apt-get install compizconfig-settings-manager
```
6. Launch *CompizConfig*, click on *OpenGL*, put Texture Filter: *Fast*, uncheck *Framebuffer object*
7. Reboot your machine, and execute ```run.sh``` or ```run_gpu.sh```.

Running the image natively might cause the Docker disk image to grow indefinitely, a known bug in Docker to which a workaround exists [here](https://github.com/docker/for-mac/issues/371#issuecomment-315385246).

## Save changes
Commit changes made to the container (e.g. installations, file changes inside the container and not a shared volume) via
```bash
docker commit $CONTAINER
```
Where `$CONTAINER` is the ID of the docker container. Issue `docker ps` to see all installed containers and their ID's.

## Resume
Start and reattach an existing docker container via
```bash
docker start  $CONTAINER
docker attach $CONTAINER
```
Where `$CONTAINER` is the ID of the docker container. Issue `docker ps` to see all installed containers and their ID's.

## Examples
Here are some cool demos to run:

### Roboschool
```bash
[vglrun] python3 $ROBOSCHOOL_PATH/agent_zoo/demo_race1.py
```
```bash
[vglrun] python3 $ROBOSCHOOL_PATH/agent_zoo/demo_keyboard_humanoid1.py
```
VirtualGL (`vglrun`) is required to support hardware-accelerated rendering if the NVIDIA drivers are not set up.
*This command should be omitted when running the NVIDIA GPU version of this container.*

### MuJoCo
Make sure the OpenGL libraries from your host system are available in `/external_libs`, as configured when running the container via `run_gpu.sh`.
```bash
cd ~/.mujoco/mjpro150/bin
LD_LIBRARY_PATH=.:/external_libs/ ./simulate ../model/humanoid.xml
```

### OpenAI Gym (from the [OpenAI blog post on DQN](https://blog.openai.com/openai-baselines-dqn/))
```bash
# Train model and save the results to cartpole_model.pkl
python3 -m baselines.deepq.experiments.train_cartpole
# Load the model saved in cartpole_model.pkl and visualize the learned policy
python3 -m baselines.deepq.experiments.enjoy_cartpole
```

## TODO
* Fix Roboschool, Baselines dependency to specific GitHub-commit(?), retry full install on OSX/improve
