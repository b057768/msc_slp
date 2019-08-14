#!/bin/sh
# Grid Engine options (lines prefixed with #$)
# job name: -N
#$ -N cnn_r_poz
# This is where the log files will be stored, in this case, the current directory
#$ -cwd
#$ -l h_rt=48:00:00
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

# Train deep conv2conv model
python train.py -data data/random/random \
-save_model models/cnn_random_poz/cnn-random-poz \
--encoder_type cnn --decoder_type cnn --cnn_kernel_width 3 \
--layers 20 --learning_rate 0.25 --position_encoding  \
--save_checkpoint_steps 5000 --train_steps 200000 \
-world_size 1 -gpu_ranks 0 \
#--train_from models/cnn_random_poz/cnn-random-poz_step_90000.pt
