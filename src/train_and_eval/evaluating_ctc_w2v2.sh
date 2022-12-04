

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