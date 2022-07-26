#!/bin/bash

wav_path=./datas/wavs
manifest_dist=./datas/manifest


python fairseq/examples/wav2vec/wav2vec_manifest.py $wav_path --dest $manifest_dist --ext wav