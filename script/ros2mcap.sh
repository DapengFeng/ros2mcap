#!/bin/bash

directory=$1
directory=${directory%/}  # Remove trailing slash if present

if [ -z "$directory" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

mkdir -p "$directory/db3"
mkdir -p "$directory/mcap"

find "$directory" -type f -name "*.bag" | while read -r file; do
    echo "Processing $file"
    relative_path=$(realpath --relative-to="$directory" "$file")
    echo "Relative path: $relative_path"
    relative_dir=${relative_path%.bag}
    echo "Relative directory: $relative_dir"
    rosbags-convert --src $file --dst $directory/db3/$relative_dir
    cat > convert.yaml << EOF
output_bags:
  - uri: $directory/mcap/$relative_dir
    storage_id: mcap
    all: true
EOF
    ros2 bag convert -i $directory/db3/$relative_dir -o convert.yaml
    echo "------------------------------"
    rm -rf "$directory/db3/$relative_dir"
done

rm -rf "$directory/db3"
rm -f convert.yaml
