FROM ubuntu:12.04
MAINTAINER Jesse Clark <docker@jessejohnclark.com>

# Register ROS repository
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 5523BAEEB01FA116 && \
echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list && \
echo "deb-src http://packages.ros.org/ros/ubuntu precise main" >> /etc/apt/sources.list.d/ros-latest.list

ENV ROS_DISTRO hydro

# Install ROS build tools
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nano \
    python-catkin-tools \
    python-pip \
    python-rosinstall \
    sudo

# Install ROS
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ros-${ROS_DISTRO}-ros-base
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ros-${ROS_DISTRO}-common-tutorials \
    ros-${ROS_DISTRO}-rospy-tutorials \
    ros-${ROS_DISTRO}-rosbridge-server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ros-${ROS_DISTRO}-desktop-full

# Install PAL dependencies
# note that rosdep should find these automatically, but we are being explicit
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ros-${ROS_DISTRO}-moveit-ros-move-group \
    ros-${ROS_DISTRO}-diff-drive-controller \
    ros-${ROS_DISTRO}-joy \
    ros-${ROS_DISTRO}-ecto-ros \
    ros-${ROS_DISTRO}-control-toolbox \
    ros-${ROS_DISTRO}-moveit-planners-ompl \
    ros-${ROS_DISTRO}-moveit-simple-grasps \
    ros-${ROS_DISTRO}-humanoid-nav-msgs \
    ros-${ROS_DISTRO}-joint-limits-interface \
    ros-${ROS_DISTRO}-object-recognition-ros \
    ros-${ROS_DISTRO}-moveit-fake-controller-manager \
    ros-${ROS_DISTRO}-joint-trajectory-controller \
    ros-${ROS_DISTRO}-moveit-simple-controller-manager \
    ros-${ROS_DISTRO}-ecto \
    ros-${ROS_DISTRO}-moveit-ros-visualization \
    ros-${ROS_DISTRO}-moveit-commander \
    python-scipy \
    ros-${ROS_DISTRO}-controller-manager \
    ros-${ROS_DISTRO}-joint-state-controller \
    ros-${ROS_DISTRO}-play-motion \
    ros-${ROS_DISTRO}-object-recognition-tabletop \
    ros-${ROS_DISTRO}-gazebo-ros-control

# Create nonprivileged user
RUN useradd --create-home --shell=/bin/bash rosuser

# Run rosdep
RUN rosdep init
USER rosuser
WORKDIR /home/rosuser
RUN . "/opt/ros/${ROS_DISTRO}/setup.sh" && \
rosdep update

# Build REEM workspace
RUN . "/opt/ros/${ROS_DISTRO}/setup.sh" && \
mkdir -p ~/reem-sim_ws/src && \
cd ~/reem-sim_ws/src && \
catkin_init_workspace && \
wstool init . && \
wstool merge https://raw.githubusercontent.com/pal-robotics/pal-ros-pkg/master/reem-sim-hydro.rosinstall && \
wstool update -j8
RUN . "/opt/ros/${ROS_DISTRO}/setup.sh" && \
cd ~/reem-sim_ws && \
rosdep install --from-paths src --ignore-src --rosdistro hydro -y && \
catkin_make

# remove "imu_sensor_controller" so that it will launch successfully
RUN sed -i.bak '/imu_sensor_controller/d' ~/reem-sim_ws/src/reem_robot/reem_controller_configuration/launch/default_controllers.launch

ENV EDITOR nano -wi

# Publish roscore and rosbridge port
EXPOSE 11311
EXPOSE 9090

# To run simulation:
# roslaunch reem_gazebo reem_empty_world.launch
# do we need to write different launch file for rosbridge-only?

RUN . "/opt/ros/${ROS_DISTRO}/setup.sh" && \
cd ~/reem-sim_ws/src && \
git clone https://github.com/uts-magic-lab/pyride_common_msgs.git && \
cd ~/reem-sim_ws && \
catkin_make

# RUN . "/opt/ros/${ROS_DISTRO}/setup.sh" && \
# cd ~/reem-sim_ws/src && \
# git clone --recursive https://github.com/kunle12/pyride_reem.git && \
# cd ~/reem-sim_ws && \
# catkin_make

ADD cobalt.tar.gz /
ADD assets /

ENTRYPOINT ["/usr/local/bin/ros_entrypoint"]
