# ros2mcap

> [!TIP]
> A utility script to batch convert ROS2 bag files to MCAP format.

## Overview

This repository contains a bash script that automatically finds and converts all `.bag` files in a given directory to MCAP format. The MCAP format offers better compression and faster access compared to traditional ROS bag files.

## Features

- **Batch Processing**: Automatically finds and processes all `.bag` files in a directory and subdirectories
- **Preserves Directory Structure**: Maintains the relative path structure in the output
- **Clean Output**: Removes temporary files after conversion

## Prerequisites

- ROS2 (tested with ROS2 Humble)
- `ros2 bag` command-line tools
- MCAP storage plugin for ROS2

### Installation

Install the required ROS2 MCAP storage plugin:

```bash
sudo apt install ros-${ROS_DISTRO}-rosbag2-storage-mcap
```

## Usage

```bash
./script/ros2mcap.sh <directory>
```

### Parameters

- `<directory>`: Path to the directory containing `.bag` files

### Example

```bash
# Convert all bag files in the current directory
./script/ros2mcap.sh .

# Convert all bag files in a specific directory
./script/ros2mcap.sh /path/to/ros/bags

# Convert bag files with absolute path
./script/ros2mcap.sh /home/user/ros_data
```

## Output Structure

The script creates a `mcap` subdirectory in the input directory with the converted files:

```
input_directory/
├── data/
│   └── session1.bag
├── logs/
│   └── recording.bag
└── mcap/              # Created by script
    ├── data/
    │   └── session1/  # MCAP format
    └── logs/
        └── recording/ # MCAP format
```

## How It Works

1. **Discovery**: Recursively finds all `.bag` files in the specified directory
2. **Conversion**: For each bag file:
   - Creates a YAML configuration file specifying input and output formats
   - Uses `ros2 bag convert` to transform the file to MCAP format
   - Preserves the relative directory structure
3. **Cleanup**: Removes temporary configuration files

## Configuration

The script uses the following MCAP settings:
- **Storage ID**: `mcap`

You can modify these settings in the script by editing the `convert.yaml` template.

## Error Handling

The script includes basic error handling:
- Validates input directory parameter
- Creates necessary output directories
- Provides progress feedback for each file processed

## Troubleshooting

### "No storage id specified" Error

If you encounter this error, ensure the MCAP storage plugin is installed:

```bash
sudo apt install ros-${ROS_DISTRO}-rosbag2-storage-mcap
```

### Permission Issues

Make sure the script is executable:

```bash
chmod +x script/ros2mcap.sh
```

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is open source under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

## See Also

- [MCAP Format Documentation](https://mcap.dev/)
- [ROS2 Bag Documentation](https://docs.ros.org/en/rolling/Tutorials/Beginner-CLI-Tools/Recording-And-Playing-Back-Data/Recording-And-Playing-Back-Data.html)
- [rosbag2 Storage Plugins](https://github.com/ros2/rosbag2)