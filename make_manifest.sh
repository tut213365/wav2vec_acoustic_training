#!/bin/bash

wav_path="/mnt/WDB_SSD/database/laboro_wav/"
manifest_dist=./datas/manifest


python fairseq/examples/wav2vec/wav2vec_manifest.py $wav_path --dest $manifest_dist --ext wav --valid-percent 0.01 --seed 100
