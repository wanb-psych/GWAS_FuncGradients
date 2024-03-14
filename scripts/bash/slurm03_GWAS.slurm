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
#SBATCH --time=12:00:00
#SBATCH --mail-type=NONE
#! Uncomment this to prevent the job from being requeued (e.g. if
#! interrupted by node failure or system downtime):
##SBATCH --no-requeue

bash /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/bash/run04_fastGWAS.sh variogram_z_g${1}

