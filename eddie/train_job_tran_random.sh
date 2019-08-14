#!/bin/sh
# Grid Engine options (lines prefixed with #$)
# job name: -N
#$ -N tran_rand
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

# Train transformer model
python train.py -data data/random/random \
-save_model models/tran_random/tran_random \
-layers 6 -rnn_size 512 -word_vec_size 512 -transformer_ff 2048 -heads 8  \
-encoder_type transformer -decoder_type transformer -position_encoding \
-train_steps 200000  -max_generator_batches 2 -dropout 0.1 \
-batch_size 4096 -batch_type tokens -normalization tokens  -accum_count 2 \
-optim adam -adam_beta2 0.998 -decay_method noam -warmup_steps 8000 \
-learning_rate 2 -max_grad_norm 0 -param_init 0  -param_init_glorot \
-label_smoothing 0.1 -valid_steps 10000 -save_checkpoint_steps 5000 \
-world_size 1 -gpu_ranks 0 \
#--train_from models/tran_random/tran_random_step_180000.pt
#-world_size 4 -gpu_ranks 0 1 2 3
