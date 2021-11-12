#!/usr/bin/env python3
"""Make k folds (train + val csv files) of csv dataset in chaii format.

:author: Rishabh Ranjan
"""

import argparse

import pandas as pd
from sklearn.model_selection import KFold
from tqdm.auto import tqdm

def main(args):
    if args.base is None:
        args.base = '.'.join(args.input.split('.')[:-1])
    df = pd.read_csv(args.input)
    kf = KFold(n_splits=args.k, shuffle=True, random_state=0)
    for i, (train_idx, val_idx) in enumerate(kf.split(df)):
        df.iloc[train_idx].to_csv(f'{args.base}.{i}.train.csv')
        df.iloc[val_idx].to_csv(f'{args.base}.{i}.val.csv')
        tqdm.write(f'written split {i} to ({args.base}.{i}.train.csv,' \
                f'{args.base}.{i}.val.csv).')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(__doc__)
    parser.add_argument('input', help='input path (csv)')
    parser.add_argument('k', type=int, help='number of folds')
    parser.add_argument('--base', help='make output paths <base>.i.train.csv,' \
            ' <base>.i.val.csv; default is basename of input path')
    args = parser.parse_args()
    main(args)
