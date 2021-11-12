#!/usr/bin/env python3
"""Convert csv (chaii format) to json (SQuAD format).

:author: Rishabh Ranjan
"""

import pandas as pd
from tqdm.auto import tqdm

import argparse
import json

def main(args):
    tqdm.write(f'read {args.input}...')
    df = pd.read_csv(args.input)
    tqdm.write(f'convert...')
    data = []
    for i in tqdm(range(len(df)), 'rows'):
        data.append({
            'id': df['id'][i],
            'title': 'chaii',
            'context': df['context'][i],
            'question': df['question'][i],
            'answers': {
                'text': [df['answer_text'][i]] if 'answer_text' in df else [''],
                'answer_start': [int(df['answer_start'][i])] \
                        if 'answer_start' in df else [0],
                },
            })
    tqdm.write(f'write...')
    with open(args.output, 'w') as out_file:
        json.dump({'data': data}, out_file, indent=2)
    tqdm.write(f'successfully written to {args.output}.')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(__doc__)
    parser.add_argument('input', help='input path (csv)')
    parser.add_argument('output', help='output path (json)')
    args = parser.parse_args()
    main(args)
