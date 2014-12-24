ros-docker
==========

Installation script for Robot Operating System

This is a fully-automated installation script for [ROS](http://www.ros.org/) on [Docker](https://www.docker.com/). It is set to use the [boot2docker](http://boot2docker.io/) host as an X display, `bash` as the default shell, and `nano` as the default editor.

### USAGE:

    docker build -t ros:base - < ros-base.dockerfile
    docker build -t ros:desktop - < ros-desktop.dockerfile
    docker run -it -v $HOME:$HOME -e HOME=$HOME -w $PWD ros:desktop
