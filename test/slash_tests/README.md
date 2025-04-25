# Slash Tests for ROS 2 Quadrotor Simulator

This directory contains system and integration tests using the Slash testing framework.

## Directory Structure

```
slash_tests/
├── conftest.py             # Global fixtures and setup for all tests
├── test_dynamics/          # Tests for the physics simulation
├── test_sensors/           # Tests for sensor simulation
├── test_control/           # Tests for control algorithms
├── test_trajectories/      # Tests for trajectory following
└── test_integration/       # End-to-end integration tests
```

## Test Categories

1. **Dynamics Tests**: Verify the physical simulation model
   - Test quadrotor dynamics with different parameters
   - Verify physics calculations against analytical solutions
   - Test environmental effects like wind and turbulence

2. **Sensor Tests**: Verify sensor simulation 
   - Test simulated IMU with different noise profiles
   - Verify GPS simulation with position drift
   - Test camera simulation

3. **Control Tests**: Verify control algorithms
   - Test different controllers under various conditions
   - Verify stability in edge cases
   
4. **Trajectory Tests**: Verify trajectory generation and following
   - Test different trajectory patterns
   - Verify precision of trajectory following
   
5. **Integration Tests**: End-to-end tests
   - Test complete simulation with all modules working together
   - Verify interfaces with external ROS 2 nodes

## Running Tests

```bash
# Install Slash
pip install slash

# Run all tests
cd /path/to/ros2_quadrotor_simulator
slash run test/slash_tests

# Run specific test category
slash run test/slash_tests/test_dynamics

# Run with specific parameter configurations
slash run test/slash_tests --with-config=config/test_configs/your_config.yaml
```

## Creating New Tests

See the examples in each test directory for how to create new tests.

Typical test structure:
```python
import slash
from ros2_quadrotor_simulator.dynamics import QuadrotorModel

def test_quadrotor_hover_stability():
    """Test that the quadrotor can maintain stable hover."""
    model = QuadrotorModel()
    
    # Setup initial conditions for hover
    model.set_position([0, 0, 1.0])  # 1m altitude
    model.set_velocity([0, 0, 0])
    
    # Run simulation for 5 seconds
    for _ in range(500):  # 10ms steps
        model.step(0.01, control_inputs=[0.5, 0.5, 0.5, 0.5])
        
        # Check if the quadrotor stays close to the hover position
        position = model.get_position()
        slash.assert_almost_equal(position[2], 1.0, delta=0.1)
```