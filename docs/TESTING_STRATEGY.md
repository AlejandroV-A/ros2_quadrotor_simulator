# Testing Strategy

This document outlines the testing approach for the ROS 2 Quadrotor Simulator project.

## Overview

The project employs a multi-level testing strategy designed to ensure both the correctness of individual components and the integrated behavior of the complete system. Given the nature of the project—simulating an AscTec Hummingbird UAV with C-based embedded components—we've adopted a dual approach to testing.

## Testing Tools

### Google Test for C/C++ Components

Google Test will be used for unit testing all C/C++ code, particularly focusing on:

1. **Embedded System Emulation** - Ensuring the C code accurately emulates the AscTec Hummingbird's embedded system behavior
2. **Physics Engine** - Verifying the correctness of dynamical equations and their implementation
3. **Low-Level Hardware Interface** - Testing the interface between simulated hardware and the ROS 2 environment

Benefits for this project:
- Well-established for C/C++ testing
- Rich assertion library suitable for testing numerical calculations
- Supports parameterized tests, which will be useful for testing physical models with different inputs
- Good integration with CI/CD systems
- Death tests can help identify critical failures in the embedded emulation

### Slash Framework for System-Level Testing

Slash will be used for system-level integration tests and scenario-based testing, with focus on:

1. **End-to-End Behavior** - Testing complete simulation scenarios
2. **ROS 2 Node Interactions** - Verifying communications between system components
3. **Trajectory Following** - Testing the quadrotor's ability to follow complex trajectories
4. **Sensor Simulation** - Verifying sensor models produce realistic data

Benefits for this project:
- Designed for testing complete products and systems
- Strong fixture model suitable for complex setup/teardown scenarios
- Rich parametrization capabilities for testing multiple conditions
- Good support for scenario-based testing
- Integration with ROS 2 will allow for testing the entire system as a unit

## Testing Levels

1. **Unit Testing**
   - Individual functions and classes
   - Isolated component behavior
   - Mock interfaces where needed
   - Implemented with Google Test for C/C++

2. **Integration Testing**
   - Interaction between components
   - Data flow between modules
   - Combined using both Google Test and Slash as appropriate

3. **System Testing**
   - Complete scenarios (e.g., following a trajectory while experiencing wind disturbances)
   - End-to-end behavior verification
   - Implemented primarily with Slash

4. **Performance Testing**
   - Real-time performance verification
   - Resource utilization
   - Implemented with custom test fixtures in Slash

## Test Data Management

1. **Trajectory Data**
   - Standard test trajectories stored in YAML format
   - Different complexity levels (simple hover, circular path, aggressive maneuvers)

2. **Environmental Conditions**
   - Standard test environments (no disturbances, wind, sensor degradation)
   - Configurable via YAML files

3. **Reference Data**
   - When possible, comparison against actual flight data from the real AscTec Hummingbird
   - Analytical solutions for simple maneuvers

## Continuous Integration

All tests will be integrated into GitHub Actions workflows to ensure:
1. Tests run automatically on pull requests
2. Tests run on multiple platforms when relevant
3. Code coverage is tracked and reported
4. Test failures prevent merging of problematic code

## Future Considerations

1. **Hardware-in-the-loop testing** - Future extension to allow testing with some real hardware components
2. **Randomized testing** - Exploring property-based testing for more robust verification
3. **Benchmarking suite** - Developing performance benchmarks to track simulator efficiency