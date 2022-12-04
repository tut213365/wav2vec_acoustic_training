

# clean CSJ manifest
manifest_dir=/home/katsuaki/wav2vec_acoustic_training/datas/manifest/cleanCSJ

# simply noised CSJ manifest
manifest_dir=/home/katsuaki/wav2vec_acoustic_training/datas/manifest/noisedCSJ/full0_20


# # clean CSJ based w2v pretrained model (from Mr.Kinouchi)
# w2vPath=/mnt/nvme_data01/matsumoto/cjs_wav2vec2.0_best_2022-11-12/wav2vec2_best-11-12/checkpoints/checkpoint_best.pt

# simply noised CSJ based w2v pretrained model
w2vPath=

# # guadually noised CSJ based w2v pretrained model
# w2vPath=/home/katsuaki/wav2vec_acoustic_training/outputs/2022-11-29/noised_rePretrain/checkpoints/checkpoint_best.pt

fairseq-hydra-train \
  common.wandb_project=wav2vec2_csj_ctc_finetuning_gradual_noised \
  common.tensorboard_logdir=log/ \
  task.data=$manifest_dir\
    model.w2v_path=$w2vPath\
    distributed_training.distributed_world_size=4 \
    +optimization.update_freq='[2]' \
    --config-dir datas/configs/finetuning/ \
    --config-name wav2vec2_base_csj
