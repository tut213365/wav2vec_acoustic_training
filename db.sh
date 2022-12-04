#### pretrained model ###
checkpoint_dir=/home/katsuaki/wav2vec_acoustic_training/outputs/models
# (C: clean, N: noised, G: gradually noised, Name: [plain_finetuning]_[CTC_finetuning]_w2v2)

# clean CSJ based w2v pretrained model (from Mr.Kinouchi)
none_none_w2v2=$checkpoint_dir/none_none_w2v2/checkpoints/checkpoint_best.pt

# re-pretrained model
N_none_w2v2=$checkpoint_dir/N_none_w2v2/checkpoints/checkpoint_best.pt
G_none_w2v2=$checkpoint_dir/G_none_w2v2/checkpoints/checkpoint_best.pt

# CTC-finetuned model
none_C_w2v2=$checkpoint_dir/none_C_w2v2/checkpoints/checkpoint_best.pt
none_N_w2v2=
N_N_w2v2=
G_G_w2v2=$checkpoint_dir/G_G_w2v2/checkpoints/checkpoint_best.pt



# number of GPU
ngpu=4

#manifestを生成するスクリプトへのパス
manifestmaker=/home/katsuaki/wav2vec2_exp/espnet/tools/anaconda/envs/espnet_wav2vec/lib/python3.8/site-packages/fairseq/examples/wav2vec/wav2vec_manifest.py

# manifest全体のディレクトリ
manifest_dir=/home/katsuaki/wav2vec_acoustic_training/datas/manifest

# 各manifestのディレクトリ
clean_mani_dir=$manifest_dir/csj
noisy_mani_dir=$manifest_dir/noised_csj
gradual_mani_dir=$manifest_dir/graduated_csj

# SNRの分割内容
snrs=(
    "0_20"
    "5_20"
    "10_20"
    "15_20"
)

# manifest生成バッチ
plain_manifest_maker=src/make_manifest/make_manifest_plain.sh
ctc_manifest_maker=src/make_manifest/make_manifest_ctc.sh
eval_manifest_maker=src/make_manifest/make_manifest_eval.sh

# trainingバッチ
evaluate_ctc_runner=src/train_and_eval/evaluating_ctc_w2v2.sh
finetune_ctc_runner=src/train_and_eval/finetuning_ctc_w2v2.sh
finetune_plain_runner=src/train_and_eval/finetuning_plain_w2v2.sh

# 各種音声ファイルの場所と拡張子
# clean CSJ
clean_wav_dir=/mnt/nvme_data01/matsumoto/dump_wav2vec2
clean_ext="flac"

# noisy CSJ
noisy_wav_dir=/mnt/nvme_data01/matsumoto/w2vNoiseTrain/MIXED_WAV/full0_20
noisy_ext="wav"

# gradually noised CSJ
grad_wav_dir=/mnt/nvme_data01/matsumoto/w2vNoiseTrain/MIXED_WAV # ここだけ各snrフォルダの親ディレクトリなので注意
grad_ext="wav"
