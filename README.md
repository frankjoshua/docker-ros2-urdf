# ROS master in Docker [![](https://img.shields.io/docker/pulls/frankjoshua/ros2-urdf)](https://hub.docker.com/r/frankjoshua/ros2-urdf) [![CI](https://github.com/frankjoshua/docker-ros2-urdf/workflows/CI/badge.svg)](https://github.com/frankjoshua/docker-ros2-urdf/actions)

## Description

Runs `robot_state_publisher` for the robomo.club robot: publishes the URDF on `/robot_description`
and the static `base_link`->sensor TF tree. Built on `ros:humble-ros-base`. Needs `--network=host`
for ROS 2 DDS discovery.

This repo is mostly an example of how to build a multi architecture docker container with ROS (Robotic Operating System). Github Actions is used to build 3 docker containers using `docker buildx` amd64 (x86 Desktop PC), arm64 (Jetson Nano) and arm32 (Raspberry Pi). This is for the purpose of developing locally on a work pc or laptop. Then being able to transfer your work to an embedded device with a high level of confidence of success.

## Example

```
docker run -it \
    --network=host \
    --ipc=host \
    --pid=host \
    frankjoshua/ros2-urdf
```

## Building

Use [build.sh](build.sh) to build the docker containers.

<br>Local builds are as follows:

```
./build.sh -t frankjoshua/ros2-urdf -l
```

## Template

This repo is a GitHub template. Just change the repo name in [.github/workflows/ci.yml](.github/workflows/ci.yml) and edit [Dockerfile](Dockerfile) and [README.md](README.md) to taste.

## Testing

Github Actions expects the DOCKERHUB_USERNAME and DOCKERHUB_TOKEN variables to be set in your environment.

## License

Apache 2.0

## Author Information

Joshua Frank [@frankjoshua77](https://www.twitter.com/@frankjoshua77)
<br>
[http://roboticsascode.com](http://roboticsascode.com)
