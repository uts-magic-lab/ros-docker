ros-docker
==========

Installation script for Robot Operating System

[![Build Status](https://travis-ci.org/uts-magic-lab/ros-docker.svg?branch=master)](https://travis-ci.org/uts-magic-lab/ros-docker)

This is a fully-automated installation script for [ROS](http://www.ros.org/) on [Docker](https://www.docker.com/). It is set to use the [boot2docker](http://boot2docker.io/) host as an X display, `bash` as the default shell, and `nano` as the default editor.

### USAGE:

Build the images:

    docker build -t ros:indigo - < ros-base:indigo.dockerfile
    docker build -t ros-desktop:indigo - < ros-desktop:indigo.dockerfile

Run ROS desktop in a container:

    docker run -it -v $HOME:$HOME -e HOME=$HOME -w $PWD ros-desktop

Run ROS desktop in a container so that rviz and X work (if rviz does not render properly, kill it with Control-C and start it again):

    XAUTH=/tmp/.docker.xauth
    touch $XAUTH
    xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
    sudo docker run -it -v $HOME:$HOME -e HOME=$HOME -w $PWD -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $XAUTH:$XAUTH -e XAUTHORITY=${XAUTH} -e QT_X11_NO_MITSHM=1 ros-desktop:indigo

Run ROS core in a container and connect to it:

    docker run -it -p 11311:11311 ros
    export ROS_MASTER_URI=http://${DOCKER_HOST}:11311/
    rosrun turtlesim turtlesim_node


Rebuild image when updates come out:

    docker build --no-cache -t ros:indigo - < ros-base:indigo.dockerfile
    docker build -t ros-desktop:indigo - < ros-desktop:indigo.dockerfile

