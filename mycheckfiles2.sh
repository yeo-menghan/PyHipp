#!/bin/bash

echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l

# Separator
echo "#==========================================================="

base_dir="/data/picasso/20181105"
files=("$base_dir/rplpl-slurm.queue1-dy-m5a-4xlarge-1.2.out" "$base_dir/rplspl-slurm.queue1-dy-m5a-4xlarge-1.3.out")

echo "Start Times"
for file in "${files[@]}"; do
    if [[ -e "$file" ]]; then
        echo "==> $(basename $file) <=="
        grep "time.struct_time" "$file" | head -n 1
    else
        echo "File $(basename $file) not found."
    fi
done

echo "End Times"
for file in "${files[@]}"; do
    if [[ -e "$file" ]]; then
        echo "==> $(basename $file) <=="
        grep "time.struct_time" "$file" | tail -n 1
        # Output the time taken (s) and MessageId
        tail -n 4 "$file"
        echo
    else
        echo "File $(basename $file) not found."
    fi
done

echo "#==========================================================="

