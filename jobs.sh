#!/bin/bash

N=chaii
for i in {0..4}
do
	qsub \
		-N $N.$i -j oe -o logs/$N.$i \
		-M cs1180416@iitd.ac.in -m bea \
		-P cse \
		-l select=1:ncpus=1:ngpus=1:centos=skylake \
		-l walltime=1:00:00 \
		-V \
		job.sh
done


