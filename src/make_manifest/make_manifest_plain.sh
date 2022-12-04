#!/bin/bash
# pretrainと同じ条件でfinetuningするためのmanifest生成．make_all_manifest.shから呼び出して実行

# trainとvalidをランダムに決める
wav_path=$wav_dir/raw/org
python $manifestmaker $wav_path --dest $manifest_dest --ext $ext --seed 100

