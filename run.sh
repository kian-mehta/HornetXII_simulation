colcon build --symlink-install --packages-select sauvc_sim
source install/setup.bash
ros2 launch sauvc_sim sauvc.launch.py