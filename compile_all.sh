#!/bin/bash

# Source folder containing .c files
source_folder="c"
# Destination folder for compiled output
compiled_folder="compiled"

# Check if the destination folder exists, create it if not
if [ ! -d "$compiled_folder" ]; then
    mkdir -p "$compiled_folder"
fi

# Iterate over each .c file in the source folder
for c_file in "$source_folder"/*.c; do
    # Check if there are matching files
    if [ -e "$c_file" ]; then
        # Extract file name without extension
        filename=$(basename "$c_file" .c)
        
        # Execute the compilation command for each file
        ./c_compiler "$c_file" "$compiled_folder/$filename.txt"
        
        # Print a message indicating completion
        echo "Compiled $c_file to $compiled_folder/$filename.txt"
    fi
done
