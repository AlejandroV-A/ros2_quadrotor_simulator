# ROS 2 Quadrotor Simulator Project Structure

This document describes the recommended folder and file structure for the project.

```
ros2_quadrotor_simulator/
├── README.md                # Main project documentation
├── COPILOT.md              # Guide for GitHub Copilot
├── LICENSE                 # MIT license file
├── .github/                # GitHub configuration
│   ├── workflows/          # GitHub Actions configuration for CI/CD
│   │   ├── build_test.yml  # Workflow for building and testing
│   │   └── lint.yml        # Workflow for static code analysis
├── config/                 # Configuration files
│   ├── quadrotor_params.yaml       # Quadrotor parameters
│   ├── sensor_params.yaml          # Sensor configuration
│   ├── controller_params.yaml      # Controller parameters
│   └── trajectories/               # Predefined trajectories
│       ├── circle.yaml             # Circular trajectory
│       └── square.yaml             # Square trajectory
├── launch/                 # Launch files
│   ├── simulation.launch.py        # Complete simulator launch
│   ├── visualization.launch.py     # Visualization-only launch
│   └── hardware_bridge.launch.py   # Hardware bridge launch
├── ros2_quadrotor_simulator/       # Main package
│   ├── __init__.py
│   ├── dynamics/                   # Physical simulation module
│   │   ├── __init__.py
│   │   ├── quadrotor_model.py      # Quadrotor dynamic model
│   │   └── environment.py          # Environment simulation
│   ├── sensors/                    # Simulated sensors module
│   │   ├── __init__.py
│   │   ├── imu.py                  # IMU simulator
│   │   ├── gps.py                  # GPS simulator
│   │   └── camera.py               # Camera simulator
│   ├── control/                    # Control module
│   │   ├── __init__.py
│   │   ├── trajectory_generator.py # Trajectory generator
│   │   └── controller.py           # Tracking controller
│   ├── interface/                  # Interface module
│   │   ├── __init__.py
│   │   ├── hardware_bridge.py      # Hardware bridge
│   │   └── real_time_manager.py    # Real-time manager
│   └── visualization/              # Visualization module
│       ├── __init__.py
│       └── visualizer.py           # RViz visualizer
├── nodes/                  # Executable scripts for each node
│   ├── dynamics_node.py            # Dynamics node
│   ├── sensor_node.py              # Sensor node
│   ├── controller_node.py          # Controller node
│   ├── interface_node.py           # Interface node
│   └── visualization_node.py       # Visualization node
├── include/                # C++ header files
│   └── ros2_quadrotor_simulator/
│       ├── dynamics/                # C++ implementations for dynamics
│       ├── sensors/                 # C++ implementations for sensors
│       └── utils/                   # C++ utilities
├── src/                    # C++ source files
│   ├── dynamics_node.cpp            # C++ implementation of dynamics node
│   ├── sensor_node.cpp              # C++ implementation of sensor node
│   └── utils.cpp                    # Utilities implementation
├── msg/                    # Custom message definitions
│   ├── QuadrotorState.msg           # Quadrotor state
│   └── SensorReading.msg            # Sensor readings
├── srv/                    # Service definitions
│   └── SetSimulationMode.srv        # Service to change simulation mode
├── action/                 # Action definitions
│   └── FollowTrajectory.action      # Trajectory following action
├── test/                   # Unit and integration tests
│   ├── test_dynamics.py             # Dynamic model tests
│   ├── test_sensors.py              # Sensor tests
│   └── test_integration.py          # Integration tests
└── setup.py                # Python packaging configuration
```

## Notes on the Structure

1. **Python/C++ Division**: Performance-critical components (such as physical simulation) can be implemented in C++, while utility components can be in Python.

2. **Modular Organization**: The structure is organized by functionality, facilitating navigation and maintenance.

3. **External Configuration**: Adjustable parameters are kept in YAML files for easy configuration without recompiling.

4. **Interface Definition**: Custom messages, services, and actions are separated to maintain a clear definition of interfaces.

5. **Testing**: A dedicated directory for tests to ensure code quality and proper functionality.

6. **Launch Files**: Launch files for different usage scenarios.