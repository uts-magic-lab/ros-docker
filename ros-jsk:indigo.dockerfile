FROM ros:indigo

USER root

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common && \
rm -rf /var/lib/apt/lists/*

ADD https://raw.github.com/jsk-ros-pkg/jsk_common/master/jsk.rosbuild /tmp/jsk.rosbuild

RUN bash /tmp/jsk.rosbuild --yes ${ROS_DISTRO} setup-ros
RUN bash /tmp/jsk.rosbuild --yes ${ROS_DISTRO} install-jsk-ros-pkg
# temporally removed from compiling
RUN rm -rf $HOME/ros/hydro/src/humanoid_stacks
RUN bash /tmp/jsk.rosbuild --yes ${ROS_DISTRO} compile-jsk-ros-pkg
# RUN yes p | bash /tmp/jsk.rosbuild ${ROS_DISTRO} test-jsk-ros-pkg

USER rosuser
