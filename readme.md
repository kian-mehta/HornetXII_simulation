## Installation

### Requirements

- Ubuntu 24.04
- ROS 2 Jazzy
- Gazebo Harmonic
- Git, colcon, rosdep, and vcstool

### 1. Clone the Hornet XII repository

```bash
cd ~
git clone https://github.com/kian-mehta/HornetXII_simulation.git
cd HornetXII_simulation
```

### 2. Install DAVE manually

DAVE is not included in this repository and must be cloned separately.

From the workspace root:

```bash
cd src

git clone -b ros2 https://github.com/IOES-Lab/dave.git
cd dave

git checkout d2121a5b4457361e60106aaa029b0a448977d70e
```

This checks out the specific DAVE revision used by our working simulation.

Verify:

```bash
git rev-parse HEAD
```

The output should be:

```text
d2121a5b4457361e60106aaa029b0a448977d70e
```

Return to the workspace root:

```bash
cd ../..
```

### 3. Install dependencies

Follow the dependency installation instructions in the [DAVE ROS 2 Native Installation Manual](https://dave-ros2.notion.site/Native-Local-Installation-Manual-7c6d7be83a4947d28ae3e3eb6b7de5ee).

**Important:** The older Jazzy `.repos` download command may return HTTP 404. Do not run that command; DAVE has already been cloned manually in Step 2.

Install the standard ROS 2 development tools if needed:

```bash
sudo apt update
sudo apt install -y \
  python3-colcon-common-extensions \
  python3-rosdep \
  python3-vcstool
```

Initialize rosdep if it has not been initialized previously:

```bash
sudo rosdep init
```

Then:

```bash
rosdep update
```

Install dependencies declared by the workspace packages:

```bash
source /opt/ros/jazzy/setup.bash

rosdep install \
  --from-paths src \
  --ignore-src \
  --rosdistro jazzy \
  -r -y
```

If dependencies remain unresolved, install them according to the DAVE documentation before building.

### 4. Build the workspace

From `~/HornetXII_simulation`:

```bash
source /opt/ros/jazzy/setup.bash

CMAKE_BUILD_PARALLEL_LEVEL=2 colcon build \
  --symlink-install \
  --executor sequential \
  --packages-skip multibeam_sonar multibeam_sonar_demo multibeam_sonar_system \
  --cmake-args -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF
```

Once the build succeeds:

```bash
source install/setup.bash
```

### 5. Run the simulation

From the workspace root:

```bash
bash run.sh
```

Alternatively:

```bash
source /opt/ros/jazzy/setup.bash
source install/setup.bash
ros2 launch sauvc_sim sauvc.launch.py
```

The simulation should launch the DAVE underwater environment, existing AUV test robot, SAUVC pool, and gate.

### Notes

- Always run `run.sh` from the workspace root.
- Stop any existing Gazebo simulation before launching another instance.