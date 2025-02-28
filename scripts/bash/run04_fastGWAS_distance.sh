#!/bin/bash

###Run fast GWAS
wd=/home/hpcwan1/rds/hpc-work/project/gwas_fg
gcta64=/home/hpcwan1/rds/hpc-work/software/gcta-1.94.1-linux-kernel-3-x86_64/gcta-1.94.1
# e.g., grad_refHCP_0.9
pheno=${1}
grad=${2} # which gradient

pheno_file=${wd}/results/distance/${pheno}/euclidean_distance.txt
qcov=${wd}/data/genetics_data/WMqcovar.txt
cov=${wd}/data/genetics_data/WMcovardiscrete.txt
out=${wd}/results/distance/${pheno}
genes=${wd}/data/genetics_data/Fast_GWAS_pathfile.txt

# Running FastGWAS for chromosome
# starts from the 3rd column, which is 1 below: -mpheno
$gcta64 --fastGWA-mlm \
        --mbfile $genes \
        --grm-sparse ${wd}/data/genetics_data/Neuroimaging_samples/sp_grm \
        --pheno ${pheno_file} \
        --mpheno ${grad} \
        --qcovar ${qcov} --covar $cov \
        --threads 20 --out ${out}/g${grad}_GWAS_auto
$gcta64 --fastGWA-mlm \
        --mbfile $genes \
        --grm-sparse ${wd}/data/genetics_data/Neuroimaging_samples/sp_grm \
        --pheno ${pheno_file} \
        --mpheno ${grad} \
        --qcovar ${qcov}  --covar $cov \
        --threads 20 \
        --model-only --keep ${wd}/data/genetics_data/Neuroimaging_samples/chrX.idlist \
        --out ${out}/g${grad}_GWAS_model
$gcta64 --bfile ${wd}/data/genetics_data/Neuroimaging_samples/ukbchr_v2_r2correct_X \
        --load-model ${out}/g${grad}_GWAS_model.fastGWA  \
        --out ${out}/g${grad}_GWAS_X --threads 20
$gcta64 --reml \
        --grm ${wd}/data/genetics_data/Neuroimaging_samples/full_grm \
        --pheno ${pheno_path}/${pheno_file} \
        --mpheno ${grad} \
        --reml-pred-rand \
        --qcovar ${qcov} --covar $cov \
        --threads 20 --out ${out}/g${grad}_GWAS_h2
python ${wd}/scripts/python/py05_GWAS_auto_X.py ${out}/g${grad}_GWAS_auto.fastGWA ${out}/g${grad}_GWAS_X.fastGWA ${out}/${pheno}_g${grad}_GWAS.txt 0.01
gzip -f ${out}/${pheno}_g${grad}_GWAS.txt
