#!/bin/bash

fairseq-hydra-train \
	task.data=/home/kinouchi/Documents/wav2vec_acoustic_training/datas/manifest \
	common.wandb_project=wav2vec_laboro2_base_CSJ \
	common.tensorboard_logdir=log/ \
	distributed_training.distributed_world_size=4 \
	+optimization.update_freq='[16]' \
  --config-dir datas/configs/ \
  --config-name wav2vec2_base_laboro
