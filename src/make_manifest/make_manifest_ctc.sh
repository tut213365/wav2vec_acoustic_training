#!/bin/bash
# CTCfinetuningのためのmanifest生成．make_all_manifest.shから呼び出して実行する

# trainとvalidの生成順を入れ替えるとうまく動かなくなる(valid.tsvはvalid-percent 0なら初期化されないが，train.tsvはmanifestmaker実行のたびに必ず初期化されるため)
wav_path=$wav_dir/raw/org/train_dev
python $manifestmaker $wav_path --dest $ctc_manifest_dest --ext $ext --valid-percent 1 --seed 100
python make_csj_asr_manifest.py $manifest_dest/valid.tsv --output-dir $ctc_manifest_dest --output-name valid

wav_path=$wav_dir/raw/org/train_nodup
python $manifestmaker $wav_path --dest $ctc_manifest_dest --ext $ext --valid-percent 0 --seed 100
python make_csj_asr_manifest.py $manifest_dest/train.tsv --output-dir $ctc_manifest_dest --output-name train

