FROM ros:humble-ros-base

# Install system dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
  python3-pip \
  python3-vcstool \
  wget \
  python3.8-dev \
  libgtest-dev \
  cppcheck \
  clang-tidy \
  && rm -rf /var/lib/apt/lists/*

# Install Python tools
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Set up workspace
RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws/src

# Copy the project
COPY . /ros2_ws/src/ros2_quadrotor_simulator/

# Build the workspace
WORKDIR /ros2_ws
RUN /bin/bash -c '. /opt/ros/humble/setup.bash && \
  colcon build --symlink-install'

# Source the workspace in .bashrc
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
  echo "source /ros2_ws/install/setup.bash" >> /root/.bashrc

# Set the workspace as working directory
WORKDIR /ros2_ws/src/ros2_quadrotor_simulator

# Default command
CMD ["/bin/bash"]
