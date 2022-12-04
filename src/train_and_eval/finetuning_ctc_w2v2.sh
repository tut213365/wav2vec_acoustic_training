
fairseq-hydra-train \
    task.data=$manifest_path \
    common.wandb_project=$proj_name \
    common.tensorboard_logdir=log/ \
    model.w2v_path=$w2v_path \
    distributed_training.distributed_world_size=$ngpu \
    +optimization.update_freq='[2]' \
  --config-dir datas/configs/finetuning/ \
  --config-name wav2vec2_base_csj
