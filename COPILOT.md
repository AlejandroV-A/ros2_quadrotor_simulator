# Guide for GitHub Copilot: ROS 2 Quadrotor Simulator

## Project Context
This project is a ROS 2-based quadrotor simulator that aims to accurately emulate real-time experiments. The goal is that other ROS 2 nodes cannot distinguish whether they are interacting with a real or simulated system.

## Technical Objectives
1. **Simulation Transparency**: The code must create a perfect abstraction layer where interfaces (topics, services, actions) are identical to those of a real quadrotor.

2. **Physical Realism**: Quadrotor dynamics must follow precise physical models including:
   - 6 degrees of freedom motion equations
   - Mass, inertia, and aerodynamic effects
   - Realistic response to control commands

3. **Sensor Simulation**: Generation of sensor data with realistic characteristics:
   - Gaussian noise in IMU sensors
   - Position drift in GPS
   - Realistic communication latency
   - Delay and synchronization effects

4. **Time Management**: The system must be able to run in:
   - Strict real-time
   - Accelerated or slowed time
   - With pause and resume capability

## Design Patterns to Use
1. **Publisher/Subscriber**: Follow the standard ROS 2 pattern for communication between nodes.
2. **Node Composition**: Favor modularity through reusable components.
3. **Bridge Pattern**: For hardware interface emulation.
4. **Factory Method**: For creating different types of simulated sensors.
5. **Strategy**: To implement different control algorithms and physical models.

## Code Conventions
1. Follow standard ROS 2 coding conventions.
2. Use descriptive names for topics following the convention: /quadrotor/[module]/[functionality]
3. Document all interfaces with descriptive comments.
4. Keep separate configuration files (YAML) for adjustable parameters.

## Key Technologies
- ROS 2 (preferably Humble or higher)
- C++ for performance-critical nodes (physical simulation)
- Python for utility nodes and tools
- YAML for configuration
- Gazebo or similar for visual simulation (optional)
- RViz for visualization
- GitHub Actions for CI/CD

## Typical Use Cases
1. Development and testing of control algorithms without real hardware
2. Validation of trajectory planning systems
3. Training of reinforcement learning-based systems
4. Integration testing of complete systems before deployment

## Success Metrics
1. The simulation must run in real-time on modest hardware
2. Simulated behavior must be indistinguishable from real behavior for other nodes
3. Clear documentation and functional examples
4. Ease of extension for new sensors or physical models