#!/bin/bash

wav_path=~/databases/laboroTV_wav/wav/
manifest_dist=./datas/manifest


python fairseq/examples/wav2vec/wav2vec_manifest.py $wav_path --dest $manifest_dist --ext wav --valid-percent 0.01 --seed 100
