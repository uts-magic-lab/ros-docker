FROM ubuntu:trusty

# Register ROS repository
RUN set -e; \
    apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 5523BAEEB01FA116; \
    echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list; \
    echo "deb-src http://packages.ros.org/ros/ubuntu trusty main" >> /etc/apt/sources.list.d/ros-latest.list

# Install ROS Base and rosinstall
RUN set -e; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y \
        ros-indigo-ros-base \
        python-rosinstall \
        nano; \
    rm -rf /var/lib/apt/lists/*

# Setup ROS environment variables globally
RUN echo 'source /opt/ros/indigo/setup.bash' >> /etc/bash.bashrc

EXPOSE 11311

# usability
RUN echo 'alias ls="ls --color=auto"' >> /etc/bash.bashrc; \
    echo 'stty erase ^?' >> /etc/bash.bashrc; \
    echo '"\e[A": history-search-backward' >> /etc/inputrc; \
    echo '"\e[B": history-search-forward' >> /etc/inputrc; \
    echo 'set show-all-if-ambiguous on' >> /etc/inputrc; \
    echo 'set completion-ignore-case on' >> /etc/inputrc
ENV TERM xterm-color

# Create nonprivileged user to run rosdep
RUN useradd --create-home --shell=/bin/bash user
USER user
ENV EDITOR nano -wi

# # Initialize rosdep
# RUN set -e; \
#     rosdep init; \
#     rosdep update; \
#     rosdep fix-permissions

CMD roscore
