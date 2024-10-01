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
#SBATCH -c 24
#SBATCH --time=4:00:00
#SBATCH --output=/dev/null
#SBATCH --mail-type=NONE
#! Uncomment this to prevent the job from being requeued (e.g. if
#! interrupted by node failure or system downtime):
##SBATCH --no-requeue

# flag should define the sparsity for gradient, like 0, 0.5, or 0.9
python /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/python/py00_generate_gradient.py $1