#!/bin/bash
set -e

src/run_qa.py \
	--model_name_or_path './runs/chaii.0.I/' \
	--cache_dir './cache' \
	--do_predict \
	--test_file './data/chaii.0.val.json' \
	--per_device_eval_batch_size 256 \
	--overwrite_cache true \
	--output_dir './runs/chaii.0.I.test/'
