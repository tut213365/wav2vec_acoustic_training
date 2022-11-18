#!/bin/bash

wav_path="/mnt/WDB_SSD/dump_csj/raw/eval1"
manifest_dist=./csj/decoding

python fairseq/examples/wav2vec/wav2vec_manifest.py $wav_path --dest $manifest_dist --ext flac --valid-percent 0 --seed 100
