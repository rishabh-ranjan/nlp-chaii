#!/bin/bash

N=smooth
for i in {9..0}
do
	qsub \
		-N $N.$i -j oe -o logs/$N.$i \
		-M $USER@iitd.ac.in -m bea \
		-P cse \
		-l select=1:ncpus=1:ngpus=1:centos=skylake \
		-l walltime=1:00:00 \
		-v I=$i \
		job.sh
done


