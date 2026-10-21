## Installation

### Requirements

- Ubuntu 24.04
- ROS 2 Jazzy
- Gazebo Harmonic
- Git
- `colcon` and ROS dependency tools

### 1. Clone the repository and DAVE submodule

```bash
cd ~
git clone --recurse-submodules https://github.com/kian-mehta/HornetXII_simulation.git
cd HornetXII_simulation
```

The `--recurse-submodules` flag downloads the DAVE repository into `src/dave` at the commit recorded by this project.

If you already cloned the project without its submodules, run:

```bash
git submodule update --init --recursive
```

### 2. Install build tools

```bash
sudo apt update
sudo apt install -y \
  python3-colcon-common-extensions \
  python3-rosdep \
  python3-vcstool
```

Initialize rosdep if necessary:

```bash
sudo rosdep init
rosdep update
```

If `rosdep init` reports that it has already been initialized, continue to `rosdep update`.

### 3. Install dependencies

From the workspace root:

```bash
source /opt/ros/jazzy/setup.bash

rosdep install \
  --from-paths src \
  --ignore-src \
  --recursive \
  --rosdistro jazzy \
  -y
```

Some DAVE dependencies may require additional setup. If rosdep reports unresolved dependencies, resolve those before building.

### 4. Build the workspace

```bash
CMAKE_BUILD_PARALLEL_LEVEL=2 colcon build \
  --symlink-install \
  --executor sequential \
  --packages-skip multibeam_sonar multibeam_sonar_demo multibeam_sonar_system \
  --cmake-args -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF
```

This uses the current workspace's build configuration and skips the three multibeam sonar packages.

### 5. Run the SAUVC simulation

```bash
source install/setup.bash
bash run.sh
```

Alternatively, launch it directly:

```bash
ros2 launch sauvc_sim sauvc.launch.py
```

Stop any previously running Gazebo simulation before starting another.