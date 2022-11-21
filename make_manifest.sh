#!/bin/bash

# wav_path=~/databases/laboroTV_wav/wav/
# wav_path=/mnt/data1/LaboroTVSpeech_v1.0d/data/train/wav
wav_path=/home/katsuaki/MIXED_WAV
manifest_dist=./datas/manifest
manifestmaker=/home/katsuaki/wav2vec2_exp/espnet/tools/anaconda/envs/espnet_wav2vec/lib/python3.8/site-packages/fairseq/examples/wav2vec/wav2vec_manifest.py

python $manifestmaker $wav_path --dest $manifest_dist --ext wav --valid-percent 0.01 --seed 100
