#!/bin/bash

# Defined durations for each job in seconds
duration_job1=1999.3222522735596
duration_job2=2754.1741626262665

# Extracted start and end times for each job
start_job1="2023-10-23 01:59:50"
end_job1="2023-10-23 02:33:10"

start_job2="2023-10-23 01:59:50"
end_job2="2023-10-23 02:45:45"

# Convert to epoch for calculations
startEpoch1=$(date --date="$start_job1" +%s)
endEpoch1=$(date --date="$end_job1" +%s)

startEpoch2=$(date --date="$start_job2" +%s)
endEpoch2=$(date --date="$end_job2" +%s)

# c. Sum of the two job durations in hours, minutes, and seconds
total_duration=$(echo "$duration_job1 + $duration_job2" | bc)
hours=$(bc <<< "$total_duration/3600")
minutes=$(bc <<< "($total_duration%3600)/60")
seconds=$(bc <<< "$total_duration%60")

echo "c. Total Duration: $hours hours, $minutes minutes, $seconds seconds"

# d. Actual time taken for both jobs to complete
actual_duration=$(echo "$endEpoch2 - $startEpoch1" | bc)
hours=$(bc <<< "$actual_duration/3600")
minutes=$(bc <<< "($actual_duration%3600)/60")
seconds=$(bc <<< "$actual_duration%60")

echo "d. Actual time taken: $hours hours, $minutes minutes, $seconds seconds"

# e. Time saved in parallelizing the jobs
time_saved=$(echo "$total_duration - $actual_duration" | bc)
hours=$(bc <<< "$time_saved/3600")
minutes=$(bc <<< "($time_saved%3600)/60")
seconds=$(bc <<< "$time_saved%60")

echo "e. Time saved: $hours hours, $minutes minutes, $seconds seconds"

# f. Time it will take to process all 110 channels
channels=110
current_channels=8
time_for_channels=$(echo "$actual_duration * ($channels/$current_channels)" | bc)
hours=$(bc <<< "$time_for_channels/3600")
minutes=$(bc <<< "($time_for_channels%3600)/60")
seconds=$(bc <<< "$time_for_channels%60")

echo "f. Time for 110 channels (estimated): $hours hours, $minutes minutes, $seconds seconds"
