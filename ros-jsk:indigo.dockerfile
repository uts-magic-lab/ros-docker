FROM maigclab/ros:indigo

USER root

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common && \
rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:webupd8team/java -y

RUN apt-get update
RUN apt-get update && \
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    aptitude \
    build-essential \
    cmake \
    git-core \
    mercurial \
    oracle-java7-installer \
    python-setuptools \
    python-yaml \
    subversion \
    wget && \
rm -rf /var/lib/apt/lists/*


ADD https://raw.github.com/jsk-ros-pkg/jsk_common/master/jsk.rosbuild /tmp/jsk.rosbuild

ENV ROS_WORKSPACE /opt/
RUN bash /tmp/jsk.rosbuild --yes ${ROS_DISTRO} setup-ros
RUN bash /tmp/jsk.rosbuild --yes ${ROS_DISTRO} install-jsk-ros-pkg
# temporally removed from compiling
RUN rm -rf $HOME/ros/hydro/src/humanoid_stacks
RUN bash /tmp/jsk.rosbuild --yes ${ROS_DISTRO} compile-jsk-ros-pkg
# RUN yes p | bash /tmp/jsk.rosbuild ${ROS_DISTRO} test-jsk-ros-pkg

USER rosuser
