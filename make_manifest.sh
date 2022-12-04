#!/bin/bash
# CTC finetuningの時に実行．gradually noised CSjのrePretrainの時はmake_manifest_noisedw2v.shを実行

# clean CSJ
# wav_dir="/home/katsuaki/WAV
# manifest_dest=./datas/manifest/cleanCSJ 

# simply noised CSJ
wav_dir=/home/katsuaki/MIXED_WAV
# manifest_dest=./datas/manifest/noisedCSJ/full0_20 # rePretrain
manifest_dest=./datas/manifest/noisedCSJ/full_CTC # CTCfinetune


# gradually noised CSJ
# wav_dir=/mnt/nvme_data01/matsumoto/w2vNoiseTrain/MIXED_WAV/all
# manifest_dest=./datas/manifest/noisedCSJ/all 

manifestmaker=/home/katsuaki/wav2vec2_exp/espnet/tools/anaconda/envs/espnet_wav2vec/lib/python3.8/site-packages/fairseq/examples/wav2vec/wav2vec_manifest.py


# # trainとvalidをランダムに決めるときに使う(repretrain)
# wav_path=$wav_dir/raw/org
# python $manifestmaker $wav_path --dest $manifest_dest --ext wav --seed 100

# train_dev=valid, train_nodup=trainのとき使う(CTC finetune)
# trainとvalidの生成順を入れ替えるとうまく動かなくなる(valid.tsvはvalid-percent 0なら初期化されないが，train.tsvはmanifestmaker実行のたびに必ず初期化されるため)
wav_path=$wav_dir/raw/org/train_dev
python $manifestmaker $wav_path --dest $manifest_dest --ext wav --valid-percent 1 --seed 100
python make_csj_asr_manifest.py $manifest_dest/valid.tsv --output-dir $manifest_dest --output-name valid

wav_path=$wav_dir/raw/org/train_nodup
python $manifestmaker $wav_path --dest $manifest_dest --ext wav --valid-percent 0 --seed 100
python make_csj_asr_manifest.py $manifest_dest/train.tsv --output-dir $manifest_dest --output-name train
