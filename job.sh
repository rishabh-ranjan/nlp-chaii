#!/bin/bash

echo "==============================="
echo $PBS_JOBID
cat $PBS_NODEFILE
echo "==============================="
cd $PBS_O_WORKDIR

export HTTP_PROXY='http://10.10.78.22:3128'
export http_proxy='http://10.10.78.22:3128'
export HTTPS_PROXY='http://10.10.78.22:3128'
export https_proxy='http://10.10.78.22:3128'

~/proxy.py 2>&1 >/dev/null &
module load apps/pytorch/1.9.0/gpu/intelpython3.7
./train.sh data/new.$I.train.json data/new.$I.val.json scratch/smooth.$I
