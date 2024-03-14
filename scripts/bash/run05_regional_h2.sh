#!/bin/bash

# e.g., r_HCP and 1 (gradient 1)
pheno=${1}
grad=${2}

gcta64=/home/hpcwan1/rds/hpc-work/software/gcta-1.94.1-linux-kernel-3-x86_64/gcta-1.94.1
pheno_path=/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/GWAS/region_g${grad}
qcov=/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/WMqcovar.txt
cov=/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/WMcovardiscrete.txt
out=${pheno_path}/node_${node}
genes=/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Fast_GWAS_pathfile.txt

if [ ! -f ${pheno_path}/${pheno}_forGWAS.txt ]; then
  python /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/python/py06_prepare_pheno_GWAS_region.py \
         ${pheno} ${grad}
  echo "${pheno_path}/${pheno}_forGWAS.txt file generated" > ${pheno_path}/log_${pheno}.log
  echo "running gcta64 --reml" >> ${pheno_path}/log_${pheno}.log       
fi

# for 360 nodes number
node=${3}
out=${pheno_path}/node_${node}
mkdir -p ${out}
$gcta64 --reml \
        --grm /home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Neuroimaging_samples/full_grm \
        --pheno ${pheno_path}/${pheno}_forGWAS.txt \
        --mpheno $((${node}+1)) \
        --reml-pred-rand \
        --qcovar $qcov --covar $cov \
        --threads 20 --out ${out}/${pheno}_h2_node_${node}