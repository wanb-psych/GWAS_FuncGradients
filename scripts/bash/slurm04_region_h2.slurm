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
#SBATCH -c 20
#SBATCH --time=2:00:00
#SBATCH --mail-type=NONE
#SBATCH --output /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/slurm-out/slurm-%j.out
#! Uncomment this to prevent the job from being requeued (e.g. if
#! interrupted by node failure or system downtime):
##SBATCH --no-requeue

# e.g., 1: r_HCP; 2: 1 (gradient 1); 3: node number
bash /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/bash/run05_regional_h2.sh ${1} ${2} ${3}