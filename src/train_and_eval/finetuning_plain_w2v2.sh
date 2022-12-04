
fairseq-hydra-train \
	task.data=$manifest_path \
	common.wandb_project=$proj_name \
    model.w2v_path=$w2v_path\
	common.tensorboard_logdir=log/ \
	distributed_training.distributed_world_size=$ngpu \
	+optimization.update_freq='[16]' \
  --config-dir datas/configs/finetuning/ \
  --config-name wav2vec2_repretrain
