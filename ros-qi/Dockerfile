FROM ros:indigo-perception

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano \
    openssh-client \
    ros-indigo-rosbridge-suite \
    ros-indigo-web-video-server && \
rm -rf /var/lib/apt/lists/*

RUN easy_install pip && \
pip install --upgrade setuptools

#RUN /usr/local/bin/pip install 'ipython[notebook]==5'

# Setup ROS environment variables globally
RUN echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> /etc/bash.bashrc

# Install pynaoqi and add to global environment
ADD pynaoqi-python2.7-2.5.5.5-linux64.tar.gz /usr/local
RUN chmod -R +r /usr/local && \
find /usr/local -type d -exec chmod +x {} \; && \
echo 'export PYTHONPATH=/usr/local/pynaoqi-python2.7-2.5.5.5-linux64/lib/python2.7/site-packages/:$PYTHONPATH' >> /etc/bash.bashrc

# Add scripts from this package
ADD assets /usr/local/

# Create nonprivileged user to run rosdep
RUN useradd --create-home --shell=/bin/bash rosuser
USER rosuser
RUN rosdep update

WORKDIR /home/rosuser/

# Interactive niceties
ENV TERM xterm-color
ENV EDITOR nano -wi

# Publish roscore port
EXPOSE 11311
EXPOSE 9090
EXPOSE 8080
EXPOSE 8888

ENTRYPOINT ["/usr/local/bin/ros_entrypoint"]
