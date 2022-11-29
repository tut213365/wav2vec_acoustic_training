#!/bin/bash
wav_path=/mnt/nvme_data01/matsumoto/w2vNoiseTrain/MIXED_WAV/all/raw
# wav_path="/home/katsuaki/WAV/raw/org"
# manifest_dest=./datas/manifest/cleanCSJ
manifest_dest=./datas/manifest/noisedCSJ/all
manifestmaker=/home/katsuaki/wav2vec2_exp/espnet/tools/anaconda/envs/espnet_wav2vec/lib/python3.8/site-packages/fairseq/examples/wav2vec/wav2vec_manifest.py

python $manifestmaker $wav_path --dest $manifest_dest --ext wav --seed 100
python make_csj_asr_manifest.py $manifest_dest/train.tsv --output-dir $manifest_dest --output-name noised_manifest
