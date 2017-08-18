FROM ros:indigo-perception

# Install debian packages
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano \
    openssh-client \
    ros-indigo-rosbridge-suite \
    ros-indigo-web-video-server && \
rm -rf /var/lib/apt/lists/*

# Install pip packages
RUN easy_install pip && \
pip install --upgrade \
    setuptools \
    requests[security] \
    'ipython[notebook]<=6.0'

# Create nonprivileged user to run rosdep
RUN useradd --create-home --shell=/bin/bash rosuser
# RUN sudo -u rosuser -H rosdep update

# Install pynaoqi and add to global environment
ADD pynaoqi-python2.7-2.5.5.5-linux64.tar.gz /usr/local/
RUN chmod -R +r /usr/local && \
find /usr/local -type d -exec chmod +x {} \;

# Add scripts from this package
ADD assets /

WORKDIR /home/rosuser/
USER rosuser

# Interactive niceties
ENV TERM xterm-color
ENV EDITOR nano -wi

# Publish roscore port
EXPOSE 11311 9090 8080 8888

ENTRYPOINT ["/usr/local/bin/ros_entrypoint"]
