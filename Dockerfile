# Pin Humble directly. Earlier this was FROM frankjoshua/ros2, a floating tag that got rebuilt on
# Jazzy ("Updated to jazzy") - a Jazzy node's Fast DDS wire format is incompatible with the Humble
# robot stack and corrupts discovery (slam drops every scan). ros:humble-ros-base already ships
# colcon and robot_state_publisher, and the URDF is plain/all-fixed-joint, so no extra packages
# (xacro, joint_state_publisher) are needed.
FROM ros:humble-ros-base

# Build the robot_description package (URDF + launch file).
WORKDIR /root
COPY ros2_ws ./ros2_ws/
RUN cd ros2_ws && . /opt/ros/$ROS_DISTRO/setup.sh && colcon build

# The entrypoint sources both /opt/ros/humble and the workspace, so launch directly (no interactive
# bashrc to depend on).
COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["ros2", "launch", "robot_description", "launch.py"]
