#!/bin/bash

N=extra
for i in 1 2 3 4 0
do
	qsub \
		-N $N.$i -j oe -o logs/$N.$i \
		-M cs1180416@iitd.ac.in -m bea \
		-P cse \
		-l select=1:ncpus=1:ngpus=1:centos=skylake \
		-l walltime=6:00:00 \
		-v i=$i \
		job.sh
done


