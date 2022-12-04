

w2vPath=/home/katsuaki/wav2vec_acoustic_training/outputs/2022-11-30/19-40-48/checkpoints/checkpoint_best.pt #noisy音声でCTC_finetuningしたやつ
# manifest_dir=/home/katsuaki/wav2vec_acoustic_training/datas/manifest/noisedCSJ/all # gradually noised CSJ
manifest_dir=/home/katsuaki/wav2vec_acoustic_training/datas/manifest/noisedCSJ/0_20 # simply noised CSJ
# manifest_dir=/home/matsumoto/wav2vec_acoustic_training/datas/manifest/noised_csj # clean CSJ

noised="" # clean音声を使うときはこっちを有効化
# noised="noised_" # noise重畳音声を使うときはこっちを有効化 

# eval1-3についてuerなど生成
evals=(
    "eval1"
    "eval2"
    "eval3"
)
for eval in "${evals[@]}";do
  fairseq-hydra-train \
      task.data=$manifest_dir/$noised$eval \
      common.tensorboard_logdir=log/ \
      model.w2v_path=$w2vPath \
      distributed_training.distributed_world_size=4 \
      +optimization.update_freq='[2]' \
    --config-dir datas/configs/evaluating/ \
    --config-name wav2vec2_ctc
done
# common.wandb_project=clean_$noised$eval \