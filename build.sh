mkdir -p $HOME/.deep-rl-docker
nvidia-docker build -f Dockerfile.gpu -t uscresl/deep-rl-docker:tf1.4.0rc1-gym0.9.4-gpu-py3 --build-arg USER=$USER --build-arg HOME=$HOME/.deep-rl-docker .