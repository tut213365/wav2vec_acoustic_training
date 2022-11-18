subset=eval1
python infer.py ../csj/decoding/ --task audio_finetuning \
--nbest 1 --path ../outputs/2022-11-07/14-32-14/checkpoints/checkpoint_last.pt --gen-subset $subset --results-path decoding --w2l-decoder fairseqlm \
--lm-model /tmp/kenlm/build/bin --lm-weight 2 --word-score -1 --sil-weight 0 --criterion ctc --labels ltr --max-tokens 4000000 \
--post-process letter
