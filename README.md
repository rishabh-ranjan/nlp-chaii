# COL772 Assignment 4: Google chaii - Hindi and Tamil Question Answering

This repository contains the scripts used to train our models on
[HPC](https://supercomputing.iitd.ac.in) for the
[Google chaii - Hindi and Tamil Question Answering](https://www.kaggle.com/c/chaii-hindi-and-tamil-question-answering/)
contest hosted on Kaggle.

Team name: KissingFace😚

Team members: [Rishabh Ranjan](https://www.kaggle.com/ranjanrishabh) and
[Daman Arora](https://www.kaggle.com/daman1209arora)

Use `--help` flag for further details on the scripts.

## HPC setup

```
module load apps/pytorch/1.9.0/gpu/intelpython3.7
python -m pip install -U -r requirements.txt
```

## Steps

1. Put full data csv file at `data/chaii.csv`. Name can be different, adapt
commandline args and script args accordingly (to experiment with different
combinations of data).

2. Make k folds as below. This will produce `data/chaii.0.train.csv`,
`data/chaii.0.val.csv`, ..., `data/chaii.{k-1}.train.csv`,
`data/chaii.{k-1}.val.csv`.
```
./kfold_csv.py data/chaii.csv 5
```

3. Convert to json:
```
for i in {0..4}; do ./csv2json.py data/chaii.train.$i.{csv,json}; ./csv2json.py data/chaii.val.$i.{csv,json}; done
```

3. Train a fold:
```
./train.sh data/chaii.0.{train,val}.json runs/chaii.0
```

OR

Submit job on HPC:
```
./jobs.sh
```

N.B.: `jobs.sh` and `job.sh` will need simple modifications such as proxy
script and email. Also change resources depending on skylake in `jobs.sh`.

4. Test a fold: (first modify the path names in the script)
```
./test.sh
```

## Acknowledgements

Scripts in `src/` are from [HuggingFace🤗 transformers](https://github.com/huggingface/transformers/tree/v4.12.3/examples/pytorch/question-answering).
