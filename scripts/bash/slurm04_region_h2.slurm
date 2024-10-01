#!/bin/bash
#!
#! Example SLURM job script for Peta4-CascadeLake (Cascade Lake CPUs, HDR IB)
#! Last updated: Fri 18 Sep 12:24:48 BST 2020
#!

#!#############################################################
#!#### Modify the options in this section as appropriate ######
#!#############################################################

#SBATCH -J cpujob
#SBATCH -p icelake
#SBATCH --nodes=1
#SBATCH -c 20
#SBATCH --time=30:00
#SBATCH --output=/dev/null
#SBATCH --mail-type=NONE
#SBATCH --output /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/slurm-out/slurm-%j.out
#! Uncomment this to prevent the job from being requeued (e.g. if
#! interrupted by node failure or system downtime):
##SBATCH --no-requeue

### Run heritability
wd=/home/hpcwan1/rds/hpc-work/project/gwas_fg

pheno=${1} # e.g., grad_refHCP_0.9
grad=${2} # which gradient

gcta64=/home/hpcwan1/rds/hpc-work/software/gcta-1.94.1-linux-kernel-3-x86_64/gcta-1.94.1
pheno_file=${wd}/results/GWAS/similarity/${pheno}/region_g${grad}/pheno.txt
qcov=${wd}/data/genetics_data/WMqcovar.txt
cov=${wd}/data/genetics_data/WMcovardiscrete.txt
out=${wd}/results/GWAS/similarity/${pheno}/region_g${grad}
pheno_file=${out}/pheno.txt
genes=${wd}/data/genetics_data/Fast_GWAS_pathfile.txt

node=${3}
mkdir -p ${out}/node_${node}
# for 360 nodes number
$gcta64 --reml \
        --grm ${wd}/data/genetics_data/Neuroimaging_samples/full_grm \
        --pheno ${pheno_file} \
        --mpheno $((${node}+2)) \
        --reml-pred-rand \
        --qcovar $qcov --covar $cov \
        --threads 20 --out ${out}/node_${node}/${pheno}_h2_node_${node}