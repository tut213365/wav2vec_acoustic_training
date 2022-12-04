

# w2v_path=/home/matsumoto/wav2vec_acoustic_training/outputs/2022-11-22/20-05-53/checkpoints/checkpoint_best.pt #clean音声でCTC_finetuningしたやつ
# manifest_dir=/home/matsumoto/wav2vec_acoustic_training/datas/manifest/csj # eval用のmanifest
# # manifest_dir=/home/matsumoto/wav2vec_acoustic_training/datas/manifest/noised_csj # eval用のmanifest

# # noised="" # clean音声を使うときはこっちを有効化
# noised="noised_" # noise重畳音声を使うときはこっちを有効化 

# eval1-3についてmanifestとdict.Itr.txt生成
evals=(
    "eval1"
    "eval2"
    "eval3"
)
for eval in "${evals[@]}";do
  fairseq-hydra-train \
      task.data=$manifest_path/$eval \
      common.tensorboard_logdir=log/ \
      model.w2v_path=$w2v_path \
      distributed_training.distributed_world_size=$ngpu \
      +optimization.update_freq='[2]' \
    --config-dir datas/configs/evaluating/ \
    --config-name wav2vec2_ctc
done