#!/bin/bash
set -e

# 🔥 Remove specified files/directories (ignore if not found)
sudo rm -rf temp_ppo_checkpoints
sudo rm -rf experiments
sudo rm -f vllm_hf_folder_cache.json

# 🚫 Kill the top GPU memory-consuming process
TOP_PID=$(nvidia-smi --query-compute-apps=pid,used_memory --format=csv,noheader,nounits \
         | sort -k2 -nr | awk -F',' '{print $1}' | tr -d ' ' | head -n1)

if [[ "$TOP_PID" =~ ^[0-9]+$ ]]; then
    echo "Killing top GPU process with PID $TOP_PID"
    sudo kill -9 "$TOP_PID"
else
    echo "No valid GPU process found to kill."
fi
