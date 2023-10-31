#!/bin/bash

# Loop through each folder in the current directory
for folder in */; do
  # Extract the folder name by removing the trailing '/'
  folder_name="${folder%/}"

  # Count the number of hkl files in the folder
  hkl_count=$(find "$folder" -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l)

  # Print the folder name and the hkl file count
  echo "$folder_name: $hkl_count"
done

