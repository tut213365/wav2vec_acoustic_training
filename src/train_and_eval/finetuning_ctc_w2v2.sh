# # simply noised CSJ
# manifest_dir=/home/matsumoto/wav2vec_acoustic_training/datas/manifest/noised_csj/full_CTC

# # clean CSJ
# # manifest_dir=/home/matsumoto/wav2vec_acoustic_training/datas/manifest/csj
# w2v_path=/home/matsumoto/wav2vec_acoustic_training/cjs_wav2vec2.0_best_2022-11-12/wav2vec2_best-11-12/checkpoints/checkpoint_best.pt # clean CSJ pretrained from T.Kinouchi

fairseq-hydra-train \
    task.data=$manifest_path \
    common.wandb_project=$proj_name \
    common.tensorboard_logdir=log/ \
    model.w2v_path=$w2v_path \
    distributed_training.distributed_world_size=$ngpu \
    +optimization.update_freq='[2]' \
  --config-dir datas/configs/finetuning/ \
  --config-name wav2vec2_base_csj
