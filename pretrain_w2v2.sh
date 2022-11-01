	#!/bin/bash

#--restore-file outputs/csj_pretrained/checkpoints/checkpoint_best.pt \
fairseq-hydra-train \
	task.data=/home/kinouchi/Documents/wav2vec_acoustic_training/datas/manifest \
	common.wandb_project=laboroTV_pretrain_base_csj \
	common.tensorboard_logdir=log/ \
	distributed_training.distributed_world_size=4 \
	+optimization.update_freq='[16]' \
    	--config-dir datas/configs/ \
    	--config-name wav2vec2_base_laborotv
    	
