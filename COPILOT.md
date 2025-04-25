# Guide for GitHub Copilot: ROS 2 Quadrotor Simulator

## Project Context
This project is a ROS 2-based quadrotor simulator that aims to accurately emulate real-time experiments using an AscTec Hummingbird UAV. The goal is that other ROS 2 nodes cannot distinguish whether they are interacting with a real or simulated system.

## Current Project Status
As of April 24, 2025:
- Project foundation established with initial documentation
- Requirements structure defined across functional, non-functional, system, and interface categories
- Git workflow established using atomic commits
- GitHub repository set up with main and develop branches
- Architecture defined but not yet implemented
- No code implementation has begun

## Technical Objectives
1. **Simulation Transparency**: The code must create a perfect abstraction layer where interfaces (topics, services, actions) are identical to those of a real AscTec Hummingbird quadrotor.

2. **Physical Realism**: Quadrotor dynamics must follow precise physical models including:
   - 6 degrees of freedom motion equations
   - Mass, inertia, and aerodynamic effects
   - Realistic response to control commands

3. **Embedded System Emulation**: Accurately emulate the AscTec Hummingbird's two-level processor architecture:
   - Low-Level Processor (LLP) for attitude control (1000 Hz)
   - High-Level Processor (HLP) for navigation (100 Hz)
   - Written in C to match the original firmware

4. **Sensor Simulation**: Generation of sensor data with realistic characteristics:
   - Gaussian noise in IMU sensors
   - Position drift in GPS
   - Realistic communication latency
   - Delay and synchronization effects

5. **Time Management**: The system must be able to run in:
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
5. Use atomic commits with structured commit messages.

## Key Technologies
- ROS 2 (preferably Humble or higher)
- C++ for performance-critical nodes (physical simulation)
- C for embedded system emulation
- Python for utility nodes and tools
- YAML for configuration
- Gazebo or similar for visual simulation (optional)
- RViz for visualization
- GitHub Actions for CI/CD
- Google Test for C/C++ unit testing
- Slash for system-level testing

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

## Project Structure
The project follows a modular structure with separate components for:
- Physical simulation
- Sensor simulation
- Embedded system emulation
- Control algorithms
- Interfaces
- Visualization

## Next Development Steps
1. Set up the ROS 2 package structure
2. Implement core dynamics model in C/C++
3. Create initial embedded system emulation
4. Develop basic sensor models
5. Integrate components into a functional simulator