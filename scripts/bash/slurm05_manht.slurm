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
#SBATCH -c 10
#SBATCH --time=2:00:00
#SBATCH --output=/dev/null
#SBATCH --mail-type=NONE
#SBATCH --output /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/slurm-out/slurm-%j.out
#! Uncomment this to prevent the job from being requeued (e.g. if
#! interrupted by node failure or system downtime):
##SBATCH --no-requeue

cd /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/r
Rscript manhtn_plot.R