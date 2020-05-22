#!/bin/bash

#SBATCH --job-name=krokodilno
#SBATCH --time=00:05:00
#SBATCH --partition=your_gpu_partition
#SBATCH --nodes=2
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G

set -x

export SIMAGE_FILENAME="/home/krokodilno/pytorch_gpu_1.4.0.simg"

# set environment for this job

HOST_CODE_DIR="/home/krokodilno/code" # THIS file dir
HOST_DATA_DIR="/data/krokodilno/datasets/segmentation"
HOST_LOG_DIR="/home/krokodilno/logs/segmentation"

CONT_CODE_DIR="/code"
CONT_DATA_DIR="/segmentation"
CONT_LOG_DIR="/logs"

TRAIN_CONF="/code/configs/config.yml"

srun singularity exec \
  --nv \
  --bind ${HOST_CODE_DIR}:${CONT_CODE_DIR}:rw \
  --bind ${HOST_DATA_DIR}:${CONT_DATA_DIR}:rw \
  --bind ${HOST_LOG_DIR}:${CONT_LOG_DIR}:rw \
  ${SIMAGE_FILENAME} \
  python train_slurm.py --config ${TRAIN_CONF}