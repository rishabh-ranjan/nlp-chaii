#!/bin/bash
set -e

# ensure 8 % TRAIN_BATCH_SIZE == 0

TRAIN_BATCH_SIZE=8	# for V100
# TRAIN_BATCH_SIZE=4	# for P100 (?), etc
# TRAIN_BATCH_SIZE=1	# for K40

EVAL_BATCH_SIZE=$((2 * TRAIN_BATCH_SIZE))	# can change to fill memory
GRAD_ACC_STEPS=$((8 / TRAIN_BATCH_SIZE))	# strict!

src/run_qa.py \
	--model_name_or_path 'deepset/xlm-roberta-large-squad2' \
	--max_seq_length 384 \
	--doc_stride 128 \
	--max_answer_length 50 \
\
	--do_train \
	--train_file "$1" \
	--fp16 true \
	--gradient_accumulation_steps $GRAD_ACC_STEPS \
	--per_device_train_batch_size $TRAIN_BATCH_SIZE \
	--learning_rate 3e-5 \
	--weight_decay 1e-2 \
	--warmup_ratio 0.2 \
	--num_train_epochs 1 \
\
	--do_eval \
	--validation_file "$2" \
	--per_device_eval_batch_size $EVAL_BATCH_SIZE \
	--evaluation_strategy 'steps' \
	--eval_steps 100 \
\
	--overwrite_cache true \
	--report_to 'none' \
	--output_dir "$3" \
	--load_best_model_at_end true \
	--save_strategy 'steps' \
	--save_steps 100 \
	--metric_for_best_model 'f1' \
	--greater_is_better true
