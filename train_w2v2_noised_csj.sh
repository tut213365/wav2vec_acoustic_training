#!/bin/bash
# snr=とw2v_path=を変更してSNRを変えながら繰り返し学習する
snr=full0_20


manifest_dir=/home/katsuaki/wav2vec_acoustic_training/datas/manifest/noisedCSJ/$snr

# (多分)5_20が終わったデータ
# w2v_path=/home/katsuaki/wav2vec_acoustic_training/outputs/2022-11-28/11-58-58/checkpoints/checkpoint_best.pt

# clean CSJ based w2v pretrained model (from Mr.Kinouchi)
w2v_path=/mnt/nvme_data01/matsumoto/cjs_wav2vec2.0_best_2022-11-12/wav2vec2_best-11-12/checkpoints/checkpoint_best.pt

fairseq-hydra-train \
	task.data=$manifest_dir \
	common.wandb_project=wav2vec_noised_CSJ_$snr \
    model.w2v_path=$w2v_path\
	common.tensorboard_logdir=log/ \
	distributed_training.distributed_world_size=4 \
	+optimization.update_freq='[16]' \
  --config-dir datas/configs/ \
  --config-name wav2vec2_noise_csj
