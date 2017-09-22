# deep-rl-docker :whale: :robot:
Docker image with OpenAI Gym, Baselines and Roboschool, utilizing TensorFlow and JupyterLab.

## Build
CPU version:
```
docker build -f Dockerfile -t uscresl/deep-rl-docker:tf1.3.0-gym0.9.3-baselines0.1.4-py3 .
```

GPU version:
```
docker build -f Dockerfile.gpu -t uscresl/deep-rl-docker:tf1.3.0-gym0.9.3-baselines0.1.4-gpu-py3 .
```

## Run
Execute `run.sh` or `run_gpu.sh`.

## TODO
* Fix Roboschool dependency to specific GitHub-commit.
