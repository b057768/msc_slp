#!/bin/sh
# Grid Engine options (lines prefixed with #$)
# job name: -N
#$ -N dec_bl_r
# This is where the log files will be stored, in this case, the current directory
#$ -cwd
#$ -l h_rt=04:00:00
# (working) memory limit
#$ -l h_vmem=32G
# Name of the project
#$ -P lel_hcrc_cstr_students
# Environment and number of cpus requested
#$ -pe gpu 1

# Load Anaconda environment
. /etc/profile.d/modules.sh

module load anaconda/5.0.1
source activate dissenv

# Run after stage_in.sh script moves preprocessed training data
# to OpenNMT/data/cnn dir

# Train conv2conv model
python translate.py -model ../export/baseline_random_step_200000.pt \
-src ../dsrtn/data/test_src.txt -output out_base_rand.txt --verbose
