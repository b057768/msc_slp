#!/bin/sh
# Grid Engine options (lines prefixed with #$)
# job name: -N
#$ -N base_rand
# This is where the log files will be stored, in this case, the current directory
#$ -cwd
#$ -l h_rt=12:00:00
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

# Train baseline unidir model
python train.py -data data/random/random -save_model models/base_rand/baseline_random \
--encoder_type rnn --decoder_type rnn --layers 2 \
--save_checkpoint_steps 10000 --train_steps 200000 \
-world_size 1 -gpu_ranks 0
#--train_from models/base_rand/baseline_random_step_50000.pt
