manifest_dir=/home/katsuaki/wav2vec_acoustic_training/datas/manifest/noisedCSJ/all
w2vPath=/home/katsuaki/wav2vec_acoustic_training/outputs/2022-11-29/noised_rePretrain/checkpoints/checkpoint_best.pt

fairseq-hydra-train \
  common.wandb_project=wav2vec2_csj_ctc_finetuning_gradual_noised \
  common.tensorboard_logdir=log/ \
  task.data=$manifest_dir\
    model.w2v_path=$w2vPath\
    distributed_training.distributed_world_size=4 \
    +optimization.update_freq='[2]' \
    --config-dir datas/configs/finetuning/ \
    --config-name wav2vec2_base_csj
