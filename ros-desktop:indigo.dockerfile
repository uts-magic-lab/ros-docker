FROM magiclab/ros:indigo
MAINTAINER Jesse Clark <docker@jessejohnclark.com>

# Install ROS Desktop
USER root
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ros-${ROS_DISTRO}-desktop-full && \
rm -rf /var/lib/apt/lists/*

# X client doesn't like to run as root
USER rosuser
ENV DISPLAY 192.168.99.3:0


# # usability
# RUN echo 'alias ls="ls --color=auto"' >> /etc/bash.bashrc; \
# echo 'stty erase ^?' >> /etc/bash.bashrc; \
# echo '"\e[A": history-search-backward' >> /etc/inputrc; \
# echo '"\e[B": history-search-forward' >> /etc/inputrc; \
# echo 'set show-all-if-ambiguous on' >> /etc/inputrc; \
# echo 'set completion-ignore-case on' >> /etc/inputrc
# ENV TERM xterm-color
# ENV EDITOR nano -wi
