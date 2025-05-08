#!/bin/bash

set -e

chmod +x ./clear_all.sh


# Constant advantage
CONFIGS=(
  "configs/polIter_rho1bSft2_const5p0_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
  "configs/polIter_rho1bSft2_const0p5_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
  "configs/polIter_rho1bSft2_const0p0_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
  "configs/polIter_rho1bSft2_constm0p5_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
  "configs/polIter_rho1bSft2_constm5p0_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
)

# GRPO
CONFIGS=(
  "configs/polIter_rho1bSft2_grpo_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
)

# # PPO
# CONFIGS=(
#   "configs/polIter_rho1bSft2_ppo_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
# )


for CONFIG in "${CONFIGS[@]}"; do
  echo "▶️ Running config: $CONFIG"
  
  export CONFIGSTR="$CONFIG"
  export APP_DIRECTORY="experiments/ppo_rho1b_gsm8k_1gpu"
  sudo docker run --ipc=host --gpus all \
  -v "$(pwd)":/src --workdir /src \
  -e CONFIGSTR="$CONFIGSTR" \
  -e APP_DIRECTORY="$APP_DIRECTORY" \
  -e APP_SEED="$APP_SEED" \
  -e WANDB_API_KEY="$WANDB_API_KEY" \
  -e WANDB_PROJECT="$WANDB_PROJECT" \
  kazemnejad/treetune:v15.1 ./run_custom.sh  # The -e is to parse env variables to the container

  
  echo "🧹 Cleaning up..."
  ./clear_all.sh
done
