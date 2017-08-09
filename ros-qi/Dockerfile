FROM ubuntu:14.04

# Register ROS repository
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-key 0xB01FA116 && \
echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list && \
echo "deb-src http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" >> /etc/apt/sources.list.d/ros-latest.list

ENV ROS_DISTRO indigo

# Install ROS base and rosinstall
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano \
    python-pip \
    python-rosinstall \
    ros-${ROS_DISTRO}-ros-base && \
rm -rf /var/lib/apt/lists/*
RUN rosdep init

# Install goodies
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ros-${ROS_DISTRO}-common-tutorials \
    ros-${ROS_DISTRO}-rospy-tutorials \
    ros-${ROS_DISTRO}-rosbridge-server && \
rm -rf /var/lib/apt/lists/*

# Setup ROS environment variables globally
RUN echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> /etc/bash.bashrc

# Create nonprivileged user to run rosdep
RUN useradd --create-home --shell=/bin/bash rosuser
USER rosuser
RUN rosdep update

ENV TERM xterm-color
ENV EDITOR nano -wi

# Publish roscore port
EXPOSE 11311
EXPOSE 9090



### TODO:
# - build ros-qi docker image with the following:
#     - install pepper sdks (2.4 or 2.5?)
#     - install python NAOqi SDK
#     - try downloading them and using ADD
# - run choreographe on host computer and get virtual robot port number
# - run ros-qi docker container with that port number 
# - run some python file inside docker container, with "import qi" and "import rospy"
