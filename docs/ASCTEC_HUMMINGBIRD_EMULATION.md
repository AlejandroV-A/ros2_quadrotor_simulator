# AscTec Hummingbird Emulation

This document outlines the approach to accurately emulate the AscTec Hummingbird quadrotor in our simulator, including its embedded system behavior.

## Overview of the AscTec Hummingbird

The AscTec Hummingbird is a small quadrotor UAV developed by Ascending Technologies with the following key characteristics:

- **Weight**: ~500g
- **Diameter**: ~55cm (rotor-to-rotor)
- **Flight Time**: ~20 minutes
- **Maximum Payload**: ~200g
- **Maximum Airspeed**: ~15 m/s
- **Processor**: ARM7 microcontroller running at 60 MHz
- **Operating System**: Custom firmware (no OS)
- **Programming Language**: C

## Embedded System Architecture

The AscTec Hummingbird has a two-level controller architecture:

1. **Low-Level Processor (LLP)**
   - Handles attitude control and motor commands
   - Runs at high frequency (1000 Hz)
   - Direct access to sensors and actuators
   - Minimal computational capabilities
   - Written in C with hard real-time constraints

2. **High-Level Processor (HLP)**
   - Handles navigation, trajectory following, and user applications
   - Runs at lower frequency (typically 100 Hz)
   - Communicates with LLP via serial interface
   - More computational power
   - Can run custom user code

## Emulation Approach

To accurately emulate the Hummingbird's embedded system:

### 1. C-based Implementation

The core flight control stack will be implemented in C to match the original firmware:

- Use the same control algorithms as the actual firmware (if available)
- Maintain the same timing constraints and execution frequency
- Preserve computational limitations of the original system
- Use Google Test for rigorous unit testing of C components

### 2. Two-level Architecture

We'll maintain the separation between Low-Level and High-Level processors:

- **embedded_llp_node**: C implementation of the low-level processor
  - Attitude stabilization
  - Direct motor control
  - IMU processing
  - Rate limiting

- **embedded_hlp_node**: C implementation of the high-level processor
  - Position control
  - Trajectory following
  - External communications

### 3. Real-Time Behavior

The simulator will enforce timing constraints similar to the real hardware:

- Ensure controller execution at appropriate frequencies
- Simulate processing delays
- Enforce memory constraints
- Replicate communication bandwidth limitations

### 4. Interface Compatibility

The simulator will expose the same interfaces as the real Hummingbird:

- Serial communication protocol
- ROS topics matching those used with the real hardware
- Same parameter structure and limitations
- Matching failure modes and error handling

## Key Behaviors to Emulate

1. **Motor Dynamics**
   - Thrust curves
   - Motor response time
   - Maximum rotational velocities
   - Temperature effects

2. **Sensor Characteristics**
   - IMU noise profiles
   - GPS position drift
   - Barometer behavior
   - Sensor fusion algorithms

3. **Control System**
   - PID controller implementation
   - Filter implementations
   - Rate limitations
   - Anti-windup mechanisms

4. **Failure Modes**
   - Low battery behavior
   - Communication dropout handling
   - Sensor failure responses
   - Emergency landing procedures

## Data Sources for Accurate Emulation

To ensure fidelity, we will use:

1. Published specifications and documentation
2. Recorded flight data from actual Hummingbird flights
3. System identification experiments (if access to hardware is available)
4. Academic papers that characterize the Hummingbird's behavior

## Verification Approach

To verify the accuracy of our emulation:

1. Compare simulator outputs to recorded data from real flights
2. Conduct blind tests where users interact with either the real system or simulator
3. Compare control system performance metrics
4. Test identical control algorithms on both simulated and real hardware

## Integration with ROS 2

The emulated embedded system will integrate with ROS 2 through:

1. A hardware abstraction layer that mimics the real serial interface
2. Topic mappings that match those used with the real hardware
3. Parameters exposed in the same way as with the physical system