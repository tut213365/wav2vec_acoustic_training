fairseq-hydra-train \
  common.wandb_project=wav2vec2_csj_ctc_finetuning \
  common.tensorboard_logdir=log/ \
  task.data=/home/katsuaki/wav2vec_acoustic_training/datas/manifest/noisedCSJ \
    model.w2v_path= \
    distributed_training.distributed_world_size=4 \
    +optimization.update_freq='[2]' \
    --config-dir datas/configs/finetuning/ \
    --config-name wav2vec2_base_csj
