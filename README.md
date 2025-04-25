# ROS 2 Quadrotor Simulator

## Description
This project implements a ROS 2 quadrotor simulator that emulates a real-time experiment with high fidelity. The main goal is to provide a platform where a virtual quadrotor follows predefined trajectories in such a way that other ROS 2 nodes cannot distinguish whether they are interacting with a real or simulated system.

The simulator specifically focuses on emulating an AscTec Hummingbird UAV, including its internal C-based embedded system behavior.

## Objectives

1. **Transparent Simulation**: Create a virtual quadrotor that is indistinguishable from a real one from the perspective of other ROS 2 nodes.

2. **Realistic Behavior**: Implement accurate physics and sensor models that closely match the behavior of the AscTec Hummingbird.

3. **Embedded System Emulation**: Emulate the C-based embedded code running on the actual Hummingbird, preserving its behaviors and limitations.

4. **Testing Platform**: Provide a reliable platform for testing control algorithms and trajectory planning without needing physical hardware.

5. **Configurable Environment**: Allow configuration of environmental conditions to test robustness of algorithms.

## Architecture

The simulator architecture is based on the following main components:

### 1. Physical Simulation Module
- **quadrotor_dynamics_node**: Implements the dynamic equations of the quadrotor.
- **physics_environment_node**: Simulates the physical environment, including effects such as wind and turbulence.

### 2. Sensor Generation Module
- **imu_simulator_node**: Generates IMU (Inertial Measurement Unit) data with realistic noise.
- **gps_simulator_node**: Simulates GPS data with realistic errors.
- **camera_simulator_node**: Generates virtual images of the environment.

### 3. Embedded System Emulation Module
- **embedded_controller_node**: C-based node that emulates the actual firmware of the AscTec Hummingbird.
- **hardware_interface_node**: Provides the same interface as the real hardware.

### 4. Control Module
- **trajectory_generator_node**: Generates reference trajectories for the quadrotor.
- **controller_node**: Implements control algorithms for trajectory tracking.

### 5. Interface Module
- **hardware_bridge_node**: Emulates the real hardware interface, maintaining the same topics, services, and message types.
- **real_time_manager_node**: Ensures that the simulation runs in real-time or with controlled time factors.

### 6. Visualization Module
- **visualization_node**: Provides 3D visualization of the quadrotor and its trajectory using RViz.

## Communication Diagram
```
                              +----------------+
                              |                |
                              | Control Module |
                              |                |
                              +-------+--------+
                                      |
                                      | (Commands)
                                      v
+----------------+         +----------+---------+        +------------------------+
|                |         |                    |        |                        |
| Sensor Module  +-------->+  Simulation Module +------->+ Embedded System Module |
|                | (Data)  |                    | (State)|                        |
+----------------+         +----------+---------+        +-----------+------------+
                                      |                              |
                                      |                              |
                                      v                              v
                             +----------------+             Other ROS 2 nodes
                             |                |           (Identical interaction
                             | Visualization  |            to a real system)
                             |                |
                             +----------------+
```

## Technology Stack

- **ROS 2 Humble**: Core middleware and communications framework
- **C/C++**: Core dynamics and embedded system emulation
  - **Google Test**: For unit testing C code components
- **Python**: High-level control and utilities
  - **Slash**: For system-level integration testing
- **YAML**: Configuration files
- **Gazebo (optional)**: For advanced visual simulation

## Testing Approach

The project uses a dual testing strategy:

1. **Google Test**: For unit testing C/C++ components, particularly the embedded system emulation and dynamics code.

2. **Slash Testing Framework**: For system-level and integration testing, targeting the complete simulator behavior.

## Current Status

The project is in the initial planning and architecture design phase. No implementation has begun yet.

## Next Steps

1. Formalize requirements and specifications
2. Define detailed interfaces between components
3. Create test specifications
4. Begin implementation of core components

## Requirements

- ROS 2 Humble or higher
- Gazebo (optional for advanced visual simulation)
- Python 3.8+
- C++17
- Google Test framework
- Slash testing framework

## Contributing
Contributions are welcome through pull requests. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](LICENSE)