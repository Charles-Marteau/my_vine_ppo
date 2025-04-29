#!/bin/bash

set -e

# 🔕 Disable Weights & Biases logging
export WANDB_MODE=disabled

# 🛠️ Fix Git safe directory warning inside Docker
git config --global --add safe.directory /src

# 🧪 Configs for VinePPO (single GPU, Rho1b on GSM8K)
CONFIGSTR="configs/polIter_rho1bSft2_vineppo_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
APP_DIRECTORY="experiments/vineppo_rho1b_gsm8k_1gpu"

export APP_SEED="2746318213"

# 📊 Get number of GPUs
NUM_GPUS=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)

echo "Running training with $NUM_GPUS GPU(s)..."
echo "Using config: $CONFIGSTR"

# 🚀 Launch training
deepspeed --no_local_rank --num_gpus=$NUM_GPUS \
    src/treetune/main.py --configs "$CONFIGSTR" \
    run_iteration_loop
