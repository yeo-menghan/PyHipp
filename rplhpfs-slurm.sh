#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=1   # number of CPUs for this task
#SBATCH -J "rplhpfs"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o rplhpfs-slurm.%N.%j.out # STDOUT
#SBATCH -e rplhpfs-slurm.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
python -u -c "import PyHipp as pyh; \
import time; \
pyh.RPLHighPass(saveLevel=1,lowFreq=250,highFreq=5000);\
pyh.FreqSpectrum(saveLevel=1,loadHighPass=True,pointsPerWindow=3000); \
print(time.localtime());"

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:018084650241:awsnotify --message "RPLHPFS Job done"
