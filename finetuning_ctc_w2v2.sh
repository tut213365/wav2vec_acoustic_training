fairseq-hydra-train \
  common.wandb_project=wav2vec2_csj_ctc_finetuning \
  common.tensorboard_logdir=log/ \
  task.data=/home/kinouchi/Documents/wav2vec_acoustic_training/csj/manifest/ \
    model.w2v_path=/home/kinouchi/Documents/wav2vec_acoustic_training/outputs/2022-11-01/csj_pretrained/checkpoints/checkpoint_best.pt \
    distributed_training.distributed_world_size=4 \
    +optimization.update_freq='[2]' \
    --config-dir datas/configs/finetuning/ \
    --config-name wav2vec2_base_csj
