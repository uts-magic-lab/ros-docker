if [ ! -z "$BASH" ]; then
    . /opt/ros/${ROS_DISTRO}/setup.bash
    . /opt/pal/cobalt/setup.bash
    . ~/reem-sim_ws/devel/setup.bash

else
    . /opt/ros/${ROS_DISTRO}/setup.sh
    . /opt/pal/cobalt/setup.sh
    . ~/reem-sim_ws/devel/setup.sh
fi
