#!/bin/bash

echo "==============================="
echo $PBS_JOBID
cat $PBS_NODEFILE
echo "==============================="
cd $PBS_O_WORKDIR

~/proxy.py 2>&1 >/dev/null &
module load apps/pytorch/1.9.0/gpu/intelpython3.7
./train.sh data/$N.$i.train.json data/$N.$i.val.json runs/$N.$i
