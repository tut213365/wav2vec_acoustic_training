#!/bin/bash

manifest_dir=/home/katsuaki/wav2vec_acoustic_training/datas/manifest # すべてのmanifestを保存しているroot
train_manifest_dest=$manifest_dir/noisedCSJ/all # 推論するモデルの学習に用いたmanifestのdir
manifest_dest=$train_manifest_dest # 推論のためのmanifestを保存するdir
manifestmaker=/home/katsuaki/wav2vec2_exp/espnet/tools/anaconda/envs/espnet_wav2vec/lib/python3.8/site-packages/fairseq/examples/wav2vec/wav2vec_manifest.py #manifestを生成するスクリプトへのパス

#クリーンデータ用
wav_dir=/mnt/nvme_data01/matsumoto/dump_wav2vec2
noised=""
ext="flac"

# ノイズ重畳データ用
# wav_dir=/mnt/nvme_data01/matsumoto/w2vNoiseTrain/MIXED_WAV/all
# noised="noised_"
# ext="wav" # wav_dirの音声の拡張子


# eval1-3についてmanifestとdict.Itr.txt生成
evals=(
    "eval1"
    "eval2"
    "eval3"
)
for eval in "${evals[@]}";do
    # 学習に用いたtoken_listを再現(dict(token_list)だけは追記されていくので実行のたび削除)
    rm -r $manifest_dest/$noised$eval
    python make_csj_asr_manifest.py $train_manifest_dest/valid.tsv --output-dir $manifest_dest/$noised$eval --output-name valid
    python make_csj_asr_manifest.py $train_manifest_dest/train.tsv --output-dir $manifest_dest/$noised$eval --output-name train

    # manifestと音声に対するラベルを生成(上で生成したものをdict以外は上書きする)
    wav_path=$wav_dir/raw/$eval
    python $manifestmaker $wav_path --dest $manifest_dest/$noised$eval --ext $ext --valid-percent 0.98 --seed 100 # train.tsvが完全に空だとエラー吐くのでvalidを0.98に設定
    python make_csj_asr_manifest.py $manifest_dest/$noised$eval/valid.tsv --output-dir $manifest_dest/$noised$eval --output-name valid --preserve-dict
    python make_csj_asr_manifest.py $manifest_dest/$noised$eval/train.tsv --output-dir $manifest_dest/$noised$eval --output-name train --preserve-dict

done