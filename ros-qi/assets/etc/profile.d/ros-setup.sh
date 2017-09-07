if [ ! -z "$BASH" ]; then
    . /opt/ros/${ROS_DISTRO}/setup.bash
else
    . /opt/ros/${ROS_DISTRO}/setup.sh
fi
