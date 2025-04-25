# Git Workflow

This document outlines the Git workflow for the ROS 2 Quadrotor Simulator project, with a particular focus on atomic commits.

## Atomic Commit Philosophy

In this project, we follow an atomic commit approach, which means:

1. **One Logical Change Per Commit**: Each commit should represent exactly one logical change to the codebase.
2. **Self-Contained Changes**: Each commit should compile, pass tests, and work correctly on its own.
3. **Complete Changes**: A change shouldn't be spread across multiple commits unless those commits form a logical sequence.

## Benefits of Atomic Commits

1. **Easier Code Review**: Reviewers can understand each change in isolation.
2. **Better Debugging**: `git bisect` becomes more effective when locating bugs.
3. **Cleaner History**: Project history becomes a meaningful narrative of changes.
4. **Selective Cherry-Picking**: Individual features or fixes can be cherry-picked to other branches.
5. **Improved Revertability**: Problematic changes can be reverted without affecting unrelated work.

## Guidelines for Atomic Commits

### 1. Commit Size

- Prefer smaller, focused commits over large, sweeping changes
- Aim for commits that can be understood in 5-10 minutes of review
- Split large changes into a series of smaller atomic commits

### 2. Commit Content

- **DO** include related changes in one commit (e.g., a feature and its tests)
- **DO NOT** include unrelated changes in the same commit (e.g., fixing a typo in a file you're not otherwise modifying)
- **DO NOT** commit incomplete features or partially implemented functionality

### 3. Commit Messages

Use a structured commit message format:

```
[Component]: Short summary (max 50 chars)

More detailed explanatory text, if necessary. Wrap it to about 72
characters. The blank line separating the summary from the body is
critical.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how. Are there side effects
or other unintuitive consequences of this change? Here's the place
to explain them.

Refer to relevant issues or requirements with: 
Fixes: #123
Implements: REQ-FR-101
```

Components might include:
- `docs`: Documentation changes
- `sim`: Simulation core
- `control`: Control system
- `sensors`: Sensor simulation
- `embedded`: Embedded system emulation
- `viz`: Visualization
- `build`: Build system changes
- `test`: Test infrastructure (not tests for features)

### 4. Branch Strategy

We use the following branch structure:

- `main`: Stable branch containing releases
- `develop`: Integration branch for ongoing development
- `feature/*`: Feature branches for specific features
- `bugfix/*`: Branches for bug fixes
- `release/*`: Release preparation branches

### 5. Workflow for New Features

1. **Create a Feature Branch**: Branch from `develop` with a descriptive name
   ```
   git checkout develop
   git pull
   git checkout -b feature/add-imu-sensor
   ```

2. **Make Incremental Atomic Commits**: As you work, commit logical units of work
   ```
   # After completing the IMU sensor interface
   git add src/sensors/imu_interface.h src/sensors/imu_interface.cpp
   git commit -m "[sensors]: Add IMU sensor interface
   
   Defines the base IMU sensor interface with configurable noise models.
   
   Implements: REQ-FR-201"
   
   # After implementing the IMU simulation
   git add src/sensors/imu_simulation.h src/sensors/imu_simulation.cpp
   git commit -m "[sensors]: Implement IMU simulation model
   
   Adds the actual simulation of accelerometer and gyroscope with proper
   noise characteristics matching the AscTec Hummingbird IMU.
   
   Implements: REQ-FR-201"
   ```

3. **Include Tests in Related Commits**: Add tests with the feature they test
   ```
   git add src/sensors/imu_noise.cpp test/sensors/test_imu_noise.cpp
   git commit -m "[sensors]: Add Gaussian noise model for IMU sensors
   
   Implements the noise model for the IMU sensors with configurable
   parameters and adds unit tests for verification.
   
   Implements: REQ-FR-201"
   ```

4. **Create Pull Request**: Once the feature is complete, create a pull request to `develop`

### 6. Code Reviews and Merging

- Each pull request requires at least one approving review
- Reviewers should review commit-by-commit first, then the entire change
- Use "Squash and Merge" only for very small, related commits in a PR
- Otherwise, preserve the atomic commit history with "Rebase and Merge"

### 7. Refactoring and Large Changes

When making large refactorings:

1. Separate functional changes from refactoring
2. Do refactoring in dedicated commits or PRs
3. Break large refactorings into smaller, atomic steps

### 8. Example Commit Sequence

Here's an example sequence of atomic commits for adding a new feature:

1. Add interface and data structures
2. Implement core logic
3. Add configuration options
4. Connect to other modules
5. Add performance optimizations
6. Add documentation

## Handling Work in Progress

Sometimes you need to save work that isn't ready for an atomic commit:

1. **Local WIP commits**: Use `git commit -m "WIP: ..."` for temporary local saving
2. **Stashing**: Use `git stash` for quick context switching
3. **Before PR**: Always clean up WIP commits by squashing or rebasing

## Tools and Hooks

We use the following tools to support our workflow:

1. **Pre-commit hooks**: Run tests and linting before allowing commits
2. **Commit templates**: Provide structure for commit messages
3. **CI verification**: Automatically verify each commit builds and passes tests

## Starting Your First Atomic Commit

For our project's first atomic commit, we'll include:

1. The initial project structure
2. Core documentation
3. Requirements documentation

This establishes the project foundation with a clean, atomic starting point.