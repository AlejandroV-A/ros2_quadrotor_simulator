# Development Environment Setup

This document describes how to set up your development environment for the ROS 2 Quadrotor Simulator project.

## System Requirements

As per REQ-SR-101, your system should meet these minimum specifications:
- 4+ CPU cores
- 8GB+ RAM
- Graphics card compatible with OpenGL 4.0+
- Ubuntu 22.04 LTS or newer (REQ-NFR-501)

## Required Software

### 1. ROS 2 Humble
The simulator requires ROS 2 Humble (REQ-SR-102). Install using:

```bash
# Set locale
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Setup Sources
sudo apt update && sudo apt install -y software-properties-common
sudo add-apt-repository universe

# Add ROS 2 GPG key
sudo apt update && sudo apt install -y curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# Add repository to sources list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS 2 packages
sudo apt update
sudo apt install -y ros-humble-desktop
sudo apt install -y ros-dev-tools
```

### 2. Development Tools

#### C/C++ Development (REQ-SR-103)
```bash
sudo apt install -y \
    build-essential \
    cmake \
    git \
    python3-colcon-common-extensions \
    python3-pip \
    python3-vcstool \
    wget
```

#### Python Development (REQ-SR-104)
```bash
sudo apt install -y \
    python3.8-dev \
    python3-pip
```

#### Install Python Dependencies
```bash
pip3 install -r requirements.txt
```

### 3. Testing Frameworks

#### Google Test
Required for C/C++ unit testing:
```bash
sudo apt install -y libgtest-dev
```

#### Slash Framework
Required for system-level testing:
```bash
pip3 install slash
```

### 4. Code Quality Tools

#### C++ Static Analysis
```bash
sudo apt install -y \
    cppcheck \
    clang-tidy
```

#### Python Linting
```bash
pip3 install \
    flake8 \
    mypy \
    pylint
```

## Docker Development Environment (REQ-NFR-502)

For consistent development environments, we provide Docker containers. Instructions for Docker setup will be provided in `docs/DOCKER_SETUP.md`.

## IDE Setup

### Visual Studio Code
1. Install VS Code
```bash
sudo snap install --classic code
```

2. Install recommended extensions:
- C/C++ Extension Pack
- Python Extension Pack
- ROS Extension
- Docker Extension
- CMake Tools
- YAML

### Configuration Files
The project includes standard configuration files for:
- `.vscode/`: VS Code workspace settings
- `.clang-format`: C++ code formatting
- `.pylintrc`: Python linting
- `setup.cfg`: Python tools configuration

## Project Build

1. Create a workspace:
```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/yourusername/ros2_quadrotor_simulator.git
```

2. Install dependencies:
```bash
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src -r -y
```

3. Build the project:
```bash
cd ~/ros2_ws
colcon build --symlink-install
```

## Environment Setup

Add the following to your `~/.bashrc`:
```bash
source /opt/ros/humble/setup.bash
source ~/ros2_ws/install/setup.bash
```

## Development Workflow

1. Follow the Git workflow described in [GIT_WORKFLOW.md](GIT_WORKFLOW.md)
2. Use pre-commit hooks for code quality checks
3. Run tests before committing:
```bash
colcon test
colcon test-result --verbose
```

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Ensure all dependencies are installed
   - Check that ROS 2 environment is properly sourced
   - Verify that your code follows our style guidelines

2. **Test Failures**
   - Check test logs in `~/ros2_ws/log/latest_test`
   - Verify that ROS 2 nodes are properly initialized in tests
   - Ensure real-time requirements are met for timing-sensitive tests

### Getting Help

1. Check existing GitHub issues
2. Consult the project documentation
3. Ask questions in the project's discussion forum
4. Contact the maintainers

## Next Steps

1. Read the [README.md](../README.md) for project overview
2. Review [CONTRIBUTING.md](../CONTRIBUTING.md) for contribution guidelines
3. Setup your Git hooks and linters
4. Try building and running the tests
5. Start with a small issue or bug fix
