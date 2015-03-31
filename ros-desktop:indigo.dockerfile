FROM ros:indigo

USER root

# Install ROS Desktop
RUN set -e; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y ros-indigo-desktop-full; \
    rm -rf /var/lib/apt/lists/*

# X client doesn't like to run as root
USER user
ENV DISPLAY 192.168.59.3:0
