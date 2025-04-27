# Interface Requirements

This document contains the interface requirements for the ROS 2 Quadrotor Simulator project. Interface requirements describe how the system communicates with external components.

## ROS 2 Interfaces

### REQ-IR-101: ROS 2 Topic Structure

**Description:** The simulator must expose the same ROS 2 topic structure as the real AscTec Hummingbird when used with ROS 2, including all essential topics for state, control, and sensor data.

**Rationale:** Ensures drop-in compatibility for testing applications designed for the real hardware.

**Verification Method:** Inspection - Compare topic list with reference implementation.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-102: Message Types

**Description:** The simulator must use standard ROS 2 message types where available, and define custom message types only when necessary.

**Rationale:** Standard message types improve interoperability with existing ROS 2 tools and packages.

**Verification Method:** Inspection - Review message type definitions.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-103: Service Interfaces

**Description:** The simulator must provide ROS 2 service interfaces for all non-continuous interactions, such as mode changes, parameter updates, and simulator control.

**Rationale:** Services are the appropriate mechanism for request-response interactions.

**Verification Method:** Test - Verify all specified services function correctly.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-104: Action Interfaces

**Description:** The simulator must provide ROS 2 action interfaces for all long-running tasks, such as trajectory following, that require feedback during execution.

**Rationale:** Actions are the appropriate mechanism for long-running tasks with feedback.

**Verification Method:** Test - Verify all specified actions function correctly.

**Priority:** Should-have

**Status:** Proposed

## Hardware Interfaces

### REQ-IR-201: Serial Interface Emulation

**Description:** The simulator must emulate the serial interface used by the real AscTec Hummingbird for communication with external systems.

**Rationale:** Serial communication is commonly used to interface with the real hardware.

**Verification Method:** Test - Verify that external systems can communicate with the simulator via the emulated serial interface.

**Priority:** Could-have

**Status:** Proposed

### REQ-IR-202: External Sensor Interfaces

**Description:** The simulator must provide interfaces for integrating external sensor simulations (e.g., cameras, LiDAR).

**Rationale:** Extensibility for different sensor configurations is important for diverse use cases.

**Verification Method:** Demonstration - Demonstrate integration of sample external sensors.

**Priority:** Should-have

**Status:** Proposed

### REQ-IR-203: OptiTrack Interface

**Description:** The simulator must provide:
1. Interface compatibility with OptiTrack's NatNet protocol (or equivalent ROS 2 bridge)
2. Topics for streaming motion capture data at configurable frame rates (100-360 Hz)
3. Separate topics for:
   - Ground truth position and attitude data for recording/visualization
   - Raw motion capture markers data (if needed for advanced applications)

**Rationale:** OptiTrack integration is essential for matching the reference testbed setup.

**Verification Method:** Test - Verify compatibility with OptiTrack data formats and protocols.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-204: Measurement Data Segregation

**Description:** The system must provide clearly separated interfaces for:
1. OptiTrack measurements: `/optitrack/pose`, `/optitrack/markers` (ground truth)
2. IMU measurements: `/quadrotor/sensors/imu` (onboard control)
3. Camera data: `/quadrotor/sensors/camera` (optional)
4. GPS data: `/quadrotor/sensors/gps` (optional)

Each interface must properly identify its data source and intended use through appropriate metadata and documentation.

**Rationale:** Clear separation of measurement sources prevents confusion and ensures proper data usage.

**Verification Method:** Inspection - Review interface definitions and documentation.

**Priority:** Must-have

**Status:** Proposed

## User Interfaces

### REQ-IR-301: Command Line Interface

**Description:** The simulator must provide a comprehensive command line interface for controlling all simulator functions.

**Rationale:** CLI support is essential for scripting and automation.

**Verification Method:** Test - Verify all functions are accessible via CLI.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-302: Configuration Files

**Description:** The simulator must support YAML-based configuration files for all simulator parameters.

**Rationale:** Configuration files allow saving and reusing simulator setups.

**Verification Method:** Test - Verify simulator can be configured via YAML files.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-303: Visualization Interface

**Description:** The simulator must provide an RViz-based visualization interface for observing the quadrotor's state and environment.

**Rationale:** Visualization is essential for debugging and demonstration.

**Verification Method:** Demonstration - Show visualization capabilities.

**Priority:** Should-have

**Status:** Proposed

## Programming Interfaces

### REQ-IR-401: C API

**Description:** The simulator must provide a C API for direct integration with embedded code developed for the AscTec Hummingbird.

**Rationale:** C is the language used in the real hardware's firmware.

**Verification Method:** Test - Verify the API functions correctly with sample embedded code.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-402: Python API

**Description:** The simulator must provide a Python API for higher-level control and integration.

**Rationale:** Python is commonly used for rapid prototyping and algorithm development.

**Verification Method:** Test - Verify the API functions correctly with sample Python code.

**Priority:** Should-have

**Status:** Proposed

### REQ-IR-403: Plugin Interface

**Description:** The simulator must provide a plugin interface for extending functionality without modifying the core codebase.

**Rationale:** Plugins allow customization and extension without core code changes.

**Verification Method:** Test - Verify plugin mechanism works with sample plugins.

**Priority:** Could-have

**Status:** Proposed

## Data Interfaces

### REQ-IR-501: Logging Interface

**Description:** The simulator must provide a configurable logging interface that can output to files, the console, and ROS 2 logging system.

**Rationale:** Flexible logging is essential for debugging and analysis.

**Verification Method:** Test - Verify logs are correctly output to all configured destinations.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-502: Data Export

**Description:** The simulator must support exporting simulation data in common formats (CSV, rosbag) for analysis.

**Rationale:** Data export enables post-simulation analysis and visualization.

**Verification Method:** Test - Verify data can be exported and used in analysis tools.

**Priority:** Must-have

**Status:** Proposed

## Research Data Interfaces

### REQ-IR-601: Control Algorithm API

**Description:** The simulator must provide a well-documented API for integrating custom control algorithms with:
- Base classes for both C++ and Python controllers
- Standard methods for state observation and control input
- Hooks for initialization and cleanup
- Access to simulator parameters and configurations

**Rationale:** Researchers need a clear and consistent way to implement their control algorithms.

**Verification Method:** Test - Verify sample controllers in both C++ and Python.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-602: Scientific Data Formats

**Description:** The simulator must support common scientific data formats:
- Input: CSV, MAT, NPY/NPZ, YAML
- Output: CSV, HDF5, MAT, ROS bags
- Plot export: PDF, PNG, SVG with LaTeX-compatible labels
- Video export: MP4, AVI with configurable codecs and quality

**Rationale:** Integration with scientific tools and publication workflows is essential.

**Verification Method:** Test - Verify all format conversions work correctly.

**Priority:** Must-have

**Status:** Proposed

### REQ-IR-603: External Tool Integration

**Description:** The simulator must provide interfaces for common research tools:
- Python scientific stack (NumPy, SciPy, Pandas)
- Popular optimization frameworks
- Common plotting libraries (Matplotlib, Plotly)

Additionally, the system should be designed with potential MATLAB/Simulink integration in mind, but this is not a tested requirement due to licensing constraints.

**Rationale:** Researchers often use external tools for analysis and visualization. While MATLAB/Simulink integration might be valuable, it cannot be a core requirement due to its proprietary nature and licensing requirements.

**Verification Method:** Test - Verify integration with each supported open-source tool. MATLAB/Simulink integration is considered optional and not part of the verification requirements.

**Priority:** Should-have (Open-source tool integration), Could-have (MATLAB/Simulink integration)

**Status:** Proposed