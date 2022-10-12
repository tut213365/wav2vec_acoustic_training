	#!/bin/bash

fairseq-hydra-train \
	task.data=/home/kinouchi/Documents/wav2vec_acoustic_training/datas/manifest \
	common.wandb_project=laboroTV_pretrain_large \
	common.tensorboard_logdir=log/ \
	distributed_training.distributed_world_size=4 \
    	--config-dir datas/configs/ \
    	--config-name wav2vec2_base_laborotv
    	
