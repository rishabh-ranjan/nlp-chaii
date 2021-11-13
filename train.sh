#!/bin/bash
set -e

TRAIN_BATCH_SIZE=16
GRAD_ACC_STEPS=$((32 / TRAIN_BATCH_SIZE))
EVAL_BATCH_SIZE=32

src/run_qa.py \
	`#--model_name_or_path 'deepset/xlm-roberta-large-squad2'` \
	--model_name_or_path './data/daman' \
	--max_seq_length 400 \
	--doc_stride 135 \
\
	--do_train \
	--train_file "$1" \
	--fp16 true \
	--gradient_accumulation_steps "$GRAD_ACC_STEPS" \
	--per_device_train_batch_size "$TRAIN_BATCH_SIZE" \
	--label_smoothing_factor 0.1 \
	--learning_rate 1e-5 \
	--weight_decay 1e-2 \
	--warmup_ratio 0.2 \
	--num_train_epochs 2 \
\
	--do_eval \
	--validation_file "$2" \
	--per_device_eval_batch_size "$EVAL_BATCH_SIZE" \
	--evaluation_strategy 'steps' \
	--eval_steps 50 \
\
	--overwrite_cache true \
	--report_to 'none' \
	--output_dir "$3" \
	--load_best_model_at_end true \
	--save_strategy 'steps' \
	--save_steps 50 \
	--metric_for_best_model 'f1' \
	--greater_is_better true \
	--save_total_limit 1 \
\
	--preprocessing_num_workers 8 \
	--dataloader_num_workers 8 \
	--group_by_length true \
	--n_best_size 5
