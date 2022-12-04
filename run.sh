#!/usr/bin/env bash
# 設定読み込み
. db.sh

# w2v_path=$none_none_w2v2
w2v_path=$N_none_w2v2
# manifest_path=$clean_mani_dir/CTCFinetuning
manifest_path=$noisy_mani_dir/CTCFinetuning
proj_name="CTCfinetune_N_N_w2v2"
# prof_name="eval"

# . $finetune_plain_runner
. $finetune_ctc_runner
# . $evaluate_ctc_runner