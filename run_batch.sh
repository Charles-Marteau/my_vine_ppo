#!/bin/bash

set -e

CONFIGS=(
  "configs/polIter_rho1bSft2_const5p0_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
  "configs/polIter_rho1bSft2_const0p5_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
  "configs/polIter_rho1bSft2_const0p0_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
  "configs/polIter_rho1bSft2_constm0p5_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
  "configs/polIter_rho1bSft2_constm5p0_GSM8K.jsonnet,configs/trainers/devBz16.jsonnet"
)

for CONFIG in "${CONFIGS[@]}"; do
  echo "▶️ Running config: $CONFIG"
  
  export CONFIGSTR="$CONFIG"
  ./run_custom.sh
  
  echo "🧹 Cleaning up..."
  ./clear_all.sh
done
