#!/bin/bash
#PBS -N kaggle -j oe -o logs/kaggle
#PBS -M $USER@iitd.ac.in -m bea
#PBS -P cse
#PBS -l select=1:ncpus=1
#PBS -l walltime=1:00:00

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
~/.local/bin/kaggle datasets create -u -r zip -p ./scratch/chaii-models-new
