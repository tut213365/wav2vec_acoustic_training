	#!/bin/bash
manifest_dist=/home/katsuaki/wav2vec_acoustic_training/datas/manifest

fairseq-hydra-train \
	task.data=$manifest_dist \
	common.wandb_project=CSJ_pretrain_base \
	common.tensorboard_logdir=log/ \
	distributed_training.distributed_world_size=4 \
	+optimization.update_freq='[16]' \
    	--config-dir datas/configs/ \
    	--config-name wav2vec2_base_laborotv
    	
