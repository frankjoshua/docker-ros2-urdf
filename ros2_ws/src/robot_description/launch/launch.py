"""robot_state_publisher for the robomo URDF.

The URDF (src/description/robot_description.urdf) is plain XML with all-fixed joints, so we read
it directly and wrap it in ParameterValue(value_type=str) for the robot_description parameter -
no xacro, and no joint_state_publisher (nothing to articulate). robot_state_publisher ships in
ros:humble-ros-base, so this joins the same Humble DDS domain as the rest of the stack.
"""
import os

from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch_ros.actions import Node
from launch_ros.parameter_descriptions import ParameterValue


def generate_launch_description():
    urdf = os.path.join(
        get_package_share_directory("robot_description"),
        "src", "description", "robot_description.urdf",
    )
    with open(urdf) as f:
        robot_description = ParameterValue(f.read(), value_type=str)

    return LaunchDescription([
        Node(
            package="robot_state_publisher",
            executable="robot_state_publisher",
            output="screen",
            parameters=[{"robot_description": robot_description}],
        ),
    ])
