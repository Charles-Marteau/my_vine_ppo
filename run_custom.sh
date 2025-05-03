#!/bin/bash

set -e

# # ✅ Authenticate to WandB
export WANDB_API_KEY=""

# ✅ Set the project you created
export WANDB_PROJECT="my_vine_ppo"

# (Optional) If you are part of a team, specify it
# export WANDB_ENTITY="your-username-or-team"

# 🛠️ Fix Git safe directory warning inside Docker
git config --global --add safe.directory /src

# 🧪 Configs (set by run_batch.sh script)
# CONFIGSTR="configs/polIter_rho1bSft2_const5p0_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
# APP_DIRECTORY="experiments/const5p0_rho1b_gsm8k_1gpu_small_batch"

export APP_SEED="2746318213"

# 📊 Get number of GPUs
NUM_GPUS=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)

echo "Running training with $NUM_GPUS GPU(s)..."
echo "Using config: $CONFIGSTR"

# 🚀 Launch training
deepspeed --no_local_rank --num_gpus=$NUM_GPUS \
    src/treetune/main.py --configs "$CONFIGSTR" \
    run_iteration_loop

