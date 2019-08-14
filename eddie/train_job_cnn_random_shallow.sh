#!/bin/sh
# Grid Engine options (lines prefixed with #$)
# job name: -N
#$ -N cnn_r_fs
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

# Train shallow conv2conv model
python train.py -data data/random/random \
-save_model models/cnn_random_shallow/cnn-random-shallow  \
--encoder_type cnn --decoder_type cnn --cnn_kernel_width 3 \
--enc_layers 3 --dec_layers 4 --train_steps 200000 \
--position_encoding  --learning_rate 0.25 --dropout 0.1 \
--save_checkpoint_steps 5000 \
-world_size 1 -gpu_ranks 0
#--train_from models/cnn_random/cnn-random-gpu_step_130000.pt
