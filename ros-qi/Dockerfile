FROM ros:indigo-perception

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano \
    ros-indigo-rosbridge-suite \
    ros-indigo-web-video-server && \
rm -rf /var/lib/apt/lists/*

# Setup ROS environment variables globally
RUN echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> /etc/bash.bashrc

# Create nonprivileged user to run rosdep
RUN useradd --create-home --shell=/bin/bash rosuser
USER rosuser
RUN rosdep update

WORKDIR /home/rosuser/

ADD assets /usr/local/
ADD pynaoqi-python2.7-2.5.5.5-linux64.tar.gz /home/rosuser/pynaoqi
USER root
RUN chown -R rosuser /home/rosuser/pynaoqi
RUN echo 'export PYTHONPATH=/home/rosuser/pynaoqi/pynaoqi-python2.7-2.5.5.5-linux64/lib/python2.7/site-packages/:$PYTHONPATH' >> /etc/bash.bashrc
USER rosuser

ENV TERM xterm-color
ENV EDITOR nano -wi

# Publish roscore port
EXPOSE 11311
EXPOSE 9090
EXPOSE 8080
EXPOSE 8888

ENTRYPOINT ["/usr/local/bin/ros_entrypoint"]


### TODO:
# - build ros-qi docker image with the following:
#     - install pepper sdks (2.4 or 2.5?)
#     - install python NAOqi SDK
#     - try downloading them and using ADD
# - run choreographe on host computer and get virtual robot port number
# - run ros-qi docker container with that port number 
# - run some python file inside docker container, with "import qi" and "import rospy"
