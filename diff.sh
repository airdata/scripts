#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <folder1> <folder2>"
    exit 1
fi

folder1="$1"
folder2="$2"

# Check if the provided paths are valid directories
if [ ! -d "$folder1" ] || [ ! -d "$folder2" ]; then
    echo "Error: Both arguments must be valid directories."
    exit 1
fi

# Run diff command on files only
diff -rq "$folder1" "$folder2"

