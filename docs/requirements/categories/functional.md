# Functional Requirements

This document contains the functional requirements for the ROS 2 Quadrotor Simulator project. Functional requirements describe what the system should do.

## Simulation Core

### REQ-FR-101: Quadrotor Dynamics Simulation

**Description:** The system must accurately simulate the dynamics of an AscTec Hummingbird quadrotor, including its physical parameters, forces, and moments.

**Rationale:** The core function of the simulator is to provide realistic behavior of the quadrotor platform.

**Verification Method:** Test - Compare simulation outputs against analytical solutions and real flight data if available.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-102: Real-time Operation

**Description:** The simulator must operate in real-time with high precision, maintaining a stable simulation frequency matching the hardware's control loop frequency (1000Hz for LLP, 100Hz for HLP). The system should support pausing, resuming, and running slower than real-time when needed for debugging.

**Rationale:** Real-time operation is essential for the simulator to be used as a drop-in replacement for the real hardware, with debugging capabilities for development.

**Verification Method:** Test - Measure execution timing and jitter under various loads.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-103: Environmental Effects

**Description:** The simulator must model environmental effects such as gravity, wind, and turbulence.

**Rationale:** These effects are present in real-world operation and affect the quadrotor's behavior.

**Verification Method:** Test - Verify that the quadrotor responds appropriately to environmental parameters.

**Priority:** Should-have

**Status:** Proposed

## Sensor Simulation

### REQ-FR-201: IMU Sensor Simulation

**Description:** The simulator must generate realistic IMU measurements including accelerometer and gyroscope data with appropriate noise characteristics matching the Hummingbird's sensors.

**Rationale:** IMU is the primary sensor for flight stability and control.

**Verification Method:** Test - Compare simulated sensor output statistics to real sensor specifications.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-202: GPS Sensor Simulation

**Description:** The simulator must generate GPS position and velocity measurements with realistic error models.

**Rationale:** GPS is commonly used for position estimation in outdoor flights.

**Verification Method:** Test - Verify that position drift and accuracy match real GPS specifications.

**Priority:** Should-have

**Status:** Proposed

### REQ-FR-203: Barometer Simulation

**Description:** The simulator must generate barometric pressure readings for altitude estimation with appropriate noise and environmental effects.

**Rationale:** Barometer is used for altitude hold and vertical velocity estimation.

**Verification Method:** Test - Compare altitude estimation from barometer readings to true altitude in simulation.

**Priority:** Should-have

**Status:** Proposed

## Embedded System Emulation

### REQ-FR-301: Low-Level Processor Emulation

**Description:** The simulator must emulate the Low-Level Processor (LLP) of the AscTec Hummingbird, implementing its attitude control algorithms in C.

**Rationale:** The LLP handles critical flight stability functions and must be accurately emulated.

**Verification Method:** Test - Compare control outputs to reference implementation.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-302: High-Level Processor Emulation

**Description:** The simulator must emulate the High-Level Processor (HLP) of the AscTec Hummingbird, supporting custom control algorithms and trajectory following.

**Rationale:** The HLP handles navigation and user-defined applications.

**Verification Method:** Test - Verify that trajectory following behavior matches expectations.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-303: Processor Communication

**Description:** The simulator must accurately emulate the communication interface between the LLP and HLP, including bandwidth limitations and latency.

**Rationale:** Communication constraints affect the overall system behavior.

**Verification Method:** Test - Measure data transfer rates and compare to hardware specifications.

**Priority:** Should-have

**Status:** Proposed

## Trajectory Generation and Control

### REQ-FR-401: Trajectory Generation

**Description:** The system must provide algorithms for generating various trajectories (e.g., lines, circles, figure-eights) with configurable parameters.

**Rationale:** Pre-defined trajectories are essential for testing control algorithms.

**Verification Method:** Demonstration - Visualize generated trajectories and verify they match specifications.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-402: Trajectory Following

**Description:** The simulator must enable the quadrotor to follow generated trajectories with configurable accuracy parameters.

**Rationale:** Trajectory following is a core capability for autonomous flight.

**Verification Method:** Test - Measure tracking error during trajectory following.

**Priority:** Must-have

**Status:** Proposed

## Visualization and Data Recording

### REQ-FR-501: 3D Visualization

**Description:** The simulator must provide 3D visualization of the quadrotor, its trajectory, and the environment.

**Rationale:** Visual feedback helps understand the system behavior and debug issues.

**Verification Method:** Demonstration - Show visualization of various flight scenarios.

**Priority:** Should-have

**Status:** Proposed

### REQ-FR-502: Data Recording

**Description:** The simulator must allow recording of all relevant data streams (state, sensor readings, control outputs) for later analysis.

**Rationale:** Data recording is essential for analysis and debugging.

**Verification Method:** Test - Verify that recorded data can be replayed and analyzed.

**Priority:** Should-have

**Status:** Proposed

## ROS 2 Integration

### REQ-FR-601: ROS 2 Topic Interface

**Description:** The simulator must expose the same ROS 2 topic interface as the real AscTec Hummingbird when used with ROS 2.

**Rationale:** Ensures that the simulator can be used as a drop-in replacement for testing ROS 2 applications.

**Verification Method:** Test - Compare topic structure with real hardware interface.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-602: Parameter Configuration

**Description:** The simulator must allow configuration of all relevant parameters through ROS 2 parameter mechanisms.

**Rationale:** Enables easy configuration and tuning of the simulator.

**Verification Method:** Test - Verify that parameter changes affect simulator behavior as expected.

**Priority:** Should-have

**Status:** Proposed

## Research Integration

### REQ-FR-701: Control Algorithm Interface

**Description:** The system must provide a standardized interface for researchers to implement and test their control algorithms, supporting both C++ and Python implementations.

**Rationale:** Easy integration of custom control algorithms is essential for research use.

**Verification Method:** Test - Verify custom controllers can be loaded and executed correctly.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-702: Research Data Input

**Description:** The system must support importing trajectory data and control parameters from common research formats including CSV, MAT files, NumPy arrays, and YAML configurations.

**Rationale:** Researchers need to easily load their experimental data and parameters.

**Verification Method:** Test - Verify data can be imported from all supported formats.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-703: Research Data Output

**Description:** The system must provide comprehensive data logging capabilities in research-friendly formats (CSV, HDF5, ROS bags) with configurable sampling rates and automatic timestamping.

**Rationale:** Data collection is critical for research publications and analysis.

**Verification Method:** Test - Verify all data formats can be correctly generated and read.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-704: Visualization and Media Generation

**Description:** The system must support generating publication-quality visualizations and video recordings of simulations, including:
- State plots with LaTeX-compatible labels
- 3D trajectory visualizations
- High-quality video recording with configurable framerates
- Real-time metric plotting

**Rationale:** Visual results are essential for publications and presentations.

**Verification Method:** Demonstration - Show generation of various visualization types.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-705: Parameter Studies

**Description:** The system must provide tools for automated parameter sweeps and batch simulations, including:
- Parameter range definition in YAML
- Parallel execution of multiple simulations
- Automated data collection and organization
- Basic statistical analysis of results

**Rationale:** Parameter studies are common in control systems research.

**Verification Method:** Test - Verify parameter sweep functionality and result collection.

**Priority:** Should-have

**Status:** Proposed

### REQ-FR-706: Performance Metrics

**Description:** The system must automatically compute and log common control performance metrics including:
- Tracking error statistics
- Control effort metrics
- Stability measures
- Custom metric definition capability

**Rationale:** Standardized metrics enable comparison of different control approaches.

**Verification Method:** Test - Verify metric computation accuracy and logging.

**Priority:** Must-have

**Status:** Proposed

## Position and Attitude Tracking

### REQ-FR-801: OptiTrack Integration

**Description:** The simulator must support OptiTrack motion capture system as the primary source of position and attitude data for experiment recording and visualization. Integration should:
- Emulate OptiTrack's data format and communication protocol
- Support typical OptiTrack frame rates (100-360 Hz)
- Include realistic measurement noise characteristics
- Handle occasional frame drops and latency

**Rationale:** OptiTrack is the primary position tracking system in the reference testbed.

**Verification Method:** Test - Verify data format and timing matches OptiTrack specifications.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-802: Position Data Sources

**Description:** The system must maintain a clear separation between:
1. OptiTrack data: Used for ground truth, visualization, and experimental data recording
2. Onboard sensor data: Used for control and state estimation
3. GPS simulation: Optional for outdoor flight simulation scenarios

**Rationale:** Clear separation between data sources ensures realistic simulation of onboard control.

**Verification Method:** Test - Verify proper data source usage in different subsystems.

**Priority:** Must-have

**Status:** Proposed

### REQ-FR-803: Camera Simulation

**Description:** The simulator should support optional onboard camera simulation for visual-based applications.

**Rationale:** While not primary for position tracking, camera simulation may be useful for future extensions.

**Verification Method:** Test - Verify camera simulation when enabled.

**Priority:** Could-have

**Status:** Proposed

### REQ-FR-804: Attitude Measurement Sources

**Description:** The system must maintain distinct handling of attitude measurements from:
1. IMU data: Primary source for onboard attitude control and state estimation
2. OptiTrack attitude data: Used for ground truth, visualization, and experimental validation
3. Ensure IMU data is used for all onboard calculations even when OptiTrack data is available

**Rationale:** Realistic simulation requires proper separation of onboard sensor data from external tracking systems.

**Verification Method:** Test - Verify proper usage of attitude data sources in different subsystems.

**Priority:** Must-have

**Status:** Proposed