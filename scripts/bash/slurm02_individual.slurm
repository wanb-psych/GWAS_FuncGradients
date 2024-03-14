#!/bin/bash
#!
#! Example SLURM job script for Peta4-CascadeLake (Cascade Lake CPUs, HDR IB)
#! Last updated: Fri 18 Sep 12:24:48 BST 2020
#!

#!#############################################################
#!#### Modify the options in this section as appropriate ######
#!#############################################################

#SBATCH -J cpujob
#SBATCH -p cclake
#SBATCH --nodes=1
#SBATCH -c 16
#SBATCH --time=12:00:00
#SBATCH --output=/dev/null
#SBATCH --mail-type=NONE
#! Uncomment this to prevent the job from being requeued (e.g. if
#! interrupted by node failure or system downtime):
##SBATCH --no-requeue

# 1: 'HCP' or 'UKB'; 2: subject txt file (relative path);
# 3: which gradient, e.g., 1 or 2 or 3; 4: save txt.

for sub in $(cat ${1})
do
python /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/python/py02_individual_similarity.py ${sub} ${2} ${3}
done