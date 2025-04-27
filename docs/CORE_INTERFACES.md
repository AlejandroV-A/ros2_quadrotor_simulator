# Core System Interfaces

This document defines the core interfaces between major system components in the ROS 2 Quadrotor Simulator.

## 1. Physical Simulation Interfaces

### 1.1 Physics Engine Interface
```cpp
// Interface for the core physics engine
class IPhysicsEngine {
    // Update physical state (called at 1000Hz)
    virtual void step(double dt) = 0;
    
    // Get/Set state
    virtual QuadrotorState getState() const = 0;
    virtual void setState(const QuadrotorState& state) = 0;
    
    // Apply forces/moments
    virtual void applyForce(const Vector3& force, const Vector3& position) = 0;
    virtual void applyMoment(const Vector3& moment) = 0;
    
    // Environment interaction
    virtual void setEnvironmentParameters(const EnvironmentParams& params) = 0;
    virtual EnvironmentParams getEnvironmentParameters() const = 0;
};
```

### 1.2 Motor Model Interface
```cpp
// Interface for motor dynamics simulation
class IMotorModel {
    // Update motor state (called at 1000Hz)
    virtual void step(double dt) = 0;
    
    // Set commanded thrust (0.0 - 1.0)
    virtual void setCommand(double command) = 0;
    
    // Get actual thrust and torque
    virtual double getThrust() const = 0;
    virtual double getTorque() const = 0;
    
    // Motor parameters
    virtual void setParameters(const MotorParams& params) = 0;
};
```

## 2. Embedded System Interfaces

### 2.1 Low-Level Processor (LLP) Interface
```cpp
// Interface for the LLP emulation (1000Hz)
class ILLP {
    // Main control loop (1000Hz)
    virtual void update() = 0;
    
    // Sensor inputs
    virtual void setIMUData(const IMUData& data) = 0;
    virtual void setMotorFeedback(const MotorFeedback& feedback) = 0;
    
    // Control outputs
    virtual MotorCommands getMotorCommands() const = 0;
    
    // Communication with HLP
    virtual void receiveFromHLP(const HLPMessage& msg) = 0;
    virtual LLPMessage sendToHLP() const = 0;
};
```

### 2.2 High-Level Processor (HLP) Interface
```cpp
// Interface for the HLP emulation (100Hz)
class IHLP {
    // Main control loop (100Hz)
    virtual void update() = 0;
    
    // Position and state inputs
    virtual void setPositionData(const PositionData& data) = 0;
    virtual void setState(const QuadrotorState& state) = 0;
    
    // Control interface
    virtual void setTrajectory(const Trajectory& trajectory) = 0;
    virtual ControlCommands getControlCommands() const = 0;
    
    // Communication with LLP
    virtual void receiveFromLLP(const LLPMessage& msg) = 0;
    virtual HLPMessage sendToLLP() const = 0;
};
```

## 3. Sensor Simulation Interfaces

### 3.1 IMU Interface
```cpp
// Interface for IMU simulation
class IIMUSensor {
    // Update sensor state (1000Hz)
    virtual void update(const QuadrotorState& state) = 0;
    
    // Get sensor readings
    virtual IMUData getData() const = 0;
    
    // Noise and bias parameters
    virtual void setParameters(const IMUParams& params) = 0;
};
```

### 3.2 GPS Interface
```cpp
// Interface for GPS simulation
class IGPSSensor {
    // Update sensor state (5Hz typical)
    virtual void update(const QuadrotorState& state) = 0;
    
    // Get sensor readings
    virtual GPSData getData() const = 0;
    
    // Error model parameters
    virtual void setParameters(const GPSParams& params) = 0;
};
```

### 3.3 OptiTrack Interface
```cpp
// Interface for OptiTrack motion capture simulation
class IOptiTrack {
    // Update tracking data (up to 360Hz)
    virtual void update(const QuadrotorState& state) = 0;
    
    // Get tracking data
    virtual OptiTrackData getData() const = 0;
    
    // Configure frame rate and error characteristics
    virtual void setParameters(const OptiTrackParams& params) = 0;
};
```

## 4. ROS 2 Communication Interfaces

### 4.1 Topic Structure
All topics follow the pattern `/quadrotor/[module]/[functionality]`

#### Core Topics
- `/quadrotor/state` (QuadrotorState, 100Hz)
- `/quadrotor/cmd_vel` (Twist, 100Hz)
- `/quadrotor/trajectory` (Trajectory, on-change)

#### Sensor Topics
- `/quadrotor/sensors/imu` (IMUData, 1000Hz)
- `/quadrotor/sensors/gps` (GPSData, 5Hz)
- `/quadrotor/sensors/optitrack` (OptiTrackData, up to 360Hz)

#### Control Topics
- `/quadrotor/control/attitude` (AttitudeCommand, 1000Hz)
- `/quadrotor/control/position` (PositionCommand, 100Hz)

### 4.2 Services
- `/quadrotor/set_mode` (SetMode)
- `/quadrotor/calibrate_imu` (Trigger)
- `/quadrotor/reset_simulation` (Trigger)

### 4.3 Actions
- `/quadrotor/follow_trajectory` (FollowTrajectory)
- `/quadrotor/takeoff` (Takeoff)
- `/quadrotor/land` (Land)

## 5. Research Integration Interfaces

### 5.1 Custom Controller Interface
```cpp
// Base class for custom controllers
class IController {
    // Core control interface (called at appropriate rate)
    virtual ControlCommands computeControls(
        const QuadrotorState& state,
        const Trajectory& reference
    ) = 0;
    
    // Parameter management
    virtual void setParameters(const YAML::Node& params) = 0;
    virtual YAML::Node getParameters() const = 0;
    
    // Performance metrics
    virtual PerformanceMetrics getMetrics() const = 0;
};
```

### 5.2 Data Recording Interface
```cpp
// Interface for data recording
class IDataRecorder {
    // Recording control
    virtual void startRecording(const std::string& filename) = 0;
    virtual void stopRecording() = 0;
    
    // Data channels
    virtual void recordState(const QuadrotorState& state) = 0;
    virtual void recordControl(const ControlCommands& commands) = 0;
    virtual void recordMetrics(const PerformanceMetrics& metrics) = 0;
    
    // Export interface
    virtual void exportToCSV(const std::string& filename) = 0;
    virtual void exportToROSBag(const std::string& filename) = 0;
    virtual void exportToHDF5(const std::string& filename) = 0;
};
```

## 6. Time Management Interface

### 6.1 Real-Time Manager
```cpp
// Interface for managing simulation timing
class ITimeManager {
    // Time control
    virtual void start() = 0;
    virtual void pause() = 0;
    virtual void resume() = 0;
    
    // Time scaling (for slow-motion debugging)
    virtual void setTimeScale(double scale) = 0;
    
    // Timing statistics
    virtual TimeStats getStats() const = 0;
    
    // Time synchronization
    virtual void synchronize() = 0;
};
```

## Message Definitions

These interfaces use the following message types, which will be defined in the ROS 2 message definitions:

```
# QuadrotorState.msg
geometry_msgs/Pose pose
geometry_msgs/Twist twist
geometry_msgs/Accel accel
float64[4] motor_speeds
time stamp

# IMUData.msg
geometry_msgs/Vector3 acceleration
geometry_msgs/Vector3 angular_velocity
geometry_msgs/Vector3 magnetic_field
float64 temperature
time stamp

# GPSData.msg
sensor_msgs/NavSatFix fix
geometry_msgs/Vector3 velocity
float64 hdop
time stamp

# OptiTrackData.msg
geometry_msgs/PoseStamped pose
float64[3][3] covariance
bool valid
time stamp

# ControlCommands.msg
float64[4] motor_commands
time stamp

# Trajectory.msg
trajectory_msgs/MultiDOFJointTrajectory trajectory
string trajectory_type
float64[] parameters
time stamp
```

## Implementation Notes

1. All interfaces should be implemented with proper error handling and input validation
2. Time synchronization must be maintained across all components
3. All parameters should be configurable through ROS 2 parameters
4. Performance metrics should be collected at all interfaces
5. Documentation must be maintained for all interface changes