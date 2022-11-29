#!/bin/bash
snrs=(
    "0_20"
    "5_20"
    "10_20"
    "15_20"
)

for snr in "${snrs[@]}";do
    wav_path=/mnt/nvme_data01/matsumoto/w2vNoiseTrain/MIXED_WAV/$snr/raw/org
    manifest_dest=./datas/manifest/noisedCSJ/$snr
    manifestmaker=/home/katsuaki/wav2vec2_exp/espnet/tools/anaconda/envs/espnet_wav2vec/lib/python3.8/site-packages/fairseq/examples/wav2vec/wav2vec_manifest.py

    python $manifestmaker $wav_path --dest $manifest_dest --ext wav --seed 100
done