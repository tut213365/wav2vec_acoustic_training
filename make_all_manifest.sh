#!/usr/bin/env bash

. db.sh # 各種設定を定義

function make_manifest(){
    local manifest_dest
    echo "$plain_manifest_maker: making manifest at $plain_manifest_dest"
    manifest_dest=$plain_manifest_dest
    . $plain_manifest_maker
    echo "$ctc_manifest_maker: making manifest at $ctc_manifest_dest"
    manifest_dest=$ctc_manifest_dest
    . $ctc_manifest_maker
    echo "$eval_manifest_maker: making manifest at $eval_manifest_dest"
    manifest_dest=$eval_manifest_dest
    . $eval_manifest_maker
}

function make_gradual_manifest(){
    local wav_dir=$wav_dir
    echo "$plain_manifest_maker: making manifest at $plain_manifest_dest"
    for snr in "${snrs[@]}";do
        manifest_dest=$plain_manifest_dest/$snr
        . $plain_manifest_maker
    done

    echo "$ctc_manifest_maker: making manifest at $ctc_manifest_dest"
    wav_dir=$wav_dir/all
    manifest_dest=$ctc_manifest_dest
    echo "$eval_manifest_maker: making manifest at $eval_manifest_dest"
    . $ctc_manifest_maker
    manifest_dest=$eval_manifest_dest
    . $eval_manifest_maker

}

### make manifest ###

echo "making manifest of cleanCSJ..."
# clean CSJ
wav_dir=$clean_wav_dir
ext=$clean_ext
plain_manifest_dest=$clean_mani_dir/PlainFinetuning
ctc_manifest_dest=$clean_mani_dir/CTCFinetuning
eval_manifest_dest=$ctc_manifest_dest

make_manifest # func実行


echo "making manifest of noisedCSJ..."
#simply noised CSJ
wav_dir=$noisy_wav_dir
ext=$noisy_ext
plain_manifest_dest=$noisy_mani_dir/PlainFinetuning
ctc_manifest_dest=$noisy_mani_dir/CTCFinetuning
eval_manifest_dest=$ctc_manifest_dest

make_manifest # func実行

echo "making manifest of gradualCSJ..."
# gradually noised CSJ
wav_dir=$grad_wav_dir
ext=$grad_ext
plain_manifest_dest=$gradual_mani_dir/PlainFinetuning
ctc_manifest_dest=$gradual_mani_dir/CTCFinetuning
eval_manifest_dest=$ctc_manifest_dest

make_gradual_manifest # func実行