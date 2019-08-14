#!/bin/sh
# Grid Engine options (lines prefixed with #$)
# job name: -N
#$ -N copy_r2
# This is where the log files will be stored, in this case, the current directory
#$ -cwd
#$ -l h_rt=08:00:00
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

# Train copy attn model
python train.py -data data/random/random_dd \
-save_model models/copy_random/copy_random  \
--encoder_type rnn --decoder_type rnn --layers 2 \
--copy_attn \
--train_steps 200000 --save_checkpoint_steps 10000 \
-world_size 1 -gpu_ranks 0
#--train_from models/cnn_random/cnn-random-gpu_step_50000.pt
