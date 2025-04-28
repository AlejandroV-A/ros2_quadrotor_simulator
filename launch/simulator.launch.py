from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='ros2_quadrotor_simulator',
            executable='simulator_node',
            name='quadrotor_simulator',
            output='screen'
        )
    ])
