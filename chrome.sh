#!/bin/bash

STATE=$(docker ps --all --filter="name=chrome" --format="exists")
if [ "$STATE" == "" ]
then
docker run -d \
  --name=chrome \
  --cap-add=SYS_ADMIN \
  --security-opt seccomp:unconfined \
  --net=host \
    --env="DISPLAY" \
    --env="HOST_UID=$(id -u)" \
    --env="HOST_GID=$(id -g)" \
    --device /dev/snd \
    --log-driver=journald \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="/dev/shm:/dev/shm:rw" \
    --volume="$HOME/downloads:/home/docker/Downloads:rw" \
    --volume="/usr/share/icons:/usr/share/icons:ro" \
    --volume="/usr/share/fonts:/usr/share/fonts:ro" \
    --volume="/etc/fonts:/etc/fonts:ro" \
    --volume="/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro" \
    --volume="$HOME/.Xauthority:/home/docker/.Xauthority:ro" \
    --volume="$HOME/.cache/google-chrome-cache:/home/docker/.cache/google-chrome:rw" \
    --volume="$HOME/.cache/google-chrome-config:/home/docker/.config/google-chrome:rw" \
    chrome
  else
    docker start chrome
  fi
