#!/bin/bash
# CTC evaluationのためのmanifest生成．make_all_manifest.shから呼び出して実行する

# eval1-3についてmanifestとdict.Itr.txt生成
evals=(
    "eval1"
    "eval2"
    "eval3"
)
for eval in "${evals[@]}";do
    # 学習に用いたtoken_listを再現(dict(token_list)だけは追記されていくので実行のたび削除)
    rm -r $manifest_dest/$eval
    python make_csj_asr_manifest.py $manifest_dest/valid.tsv --output-dir $manifest_dest/$eval --output-name valid
    python make_csj_asr_manifest.py $manifest_dest/train.tsv --output-dir $manifest_dest/$eval --output-name train

    # manifestと音声に対するラベルを生成(上で生成したものをdict以外は上書きする)
    wav_path=$wav_dir/raw/$eval
    python $manifestmaker $wav_path --dest $manifest_dest/$eval --ext $ext --valid-percent 0.98 --seed 100 # train.tsvが完全に空だとエラー吐くのでvalidを0.98に設定
    python make_csj_asr_manifest.py $manifest_dest/$eval/valid.tsv --output-dir $manifest_dest/$eval --output-name valid --preserve-dict
    python make_csj_asr_manifest.py $manifest_dest/$eval/train.tsv --output-dir $manifest_dest/$eval --output-name train --preserve-dict

done