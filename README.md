ros-docker
==========

Installation script for Robot Operating System

This is a fully-automated installation script for [ROS](http://www.ros.org/) on [Docker](https://www.docker.com/). It is set to use the [boot2docker](http://boot2docker.io/) host as an X display, `bash` as the default shell, and `nano` as the default editor.

### USAGE:

    docker build -t ros:indigo - < ros-base:indigo.dockerfile
    docker tag ros:indigo ros
    docker run -it -p 11311:11311 ros roscore

    docker build -t ros-desktop:indigo - < ros-desktop:indigo.dockerfile
    docker run -it -v $HOME:$HOME -e HOME=$HOME -w $PWD ros-desktop
