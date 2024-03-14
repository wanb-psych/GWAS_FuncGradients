#!/bin/bash

###Run fast GWAS
gcta64=/home/hpcwan1/rds/hpc-work/software/gcta-1.94.1-linux-kernel-3-x86_64/gcta-1.94.1
pheno_path=/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/overall_similarity
qcov=/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/WMqcovar.txt
cov=/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/WMcovardiscrete.txt
out=/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/GWAS
genes=/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Fast_GWAS_pathfile.txt

# e.g., variogram_z_g1
pheno=${1}

# preparing whole brain phenotypes -input and -output
python /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/python/py04_prepare_pheno_GWAS.py \
       ${pheno_path}/${pheno}.txt ${pheno_path}/${pheno}_forGWAS.txt

sleep 2
if [ ! -f ${pheno_path}/${pheno}_forGWAS.txt ]; then
  echo "...${pheno_path}/${pheno}_forGWAS.txt fail..."
  exit 1
fi

# Running FastGWAS for chromosome
# starts from the 3rd column, which is 1 below, 3 is r_HCP
rm -rf ${out}/similarity_${pheno}*
i=r_HCP
$gcta64 --fastGWA-mlm \
        --mbfile $genes \
        --grm-sparse /home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Neuroimaging_samples/sp_grm \
        --pheno ${pheno_path}/${pheno}_forGWAS.txt \
        --mpheno 3 \
        --qcovar $qcov --covar $cov \
        --threads 20 --out ${out}/similarity_${pheno}_GWAS_auto_$i
$gcta64 --fastGWA-mlm \
        --mbfile $genes \
        --grm-sparse /home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Neuroimaging_samples/sp_grm \
        --pheno ${pheno_path}/${pheno}_forGWAS.txt \
        --mpheno 3 \
        --qcovar $qcov --covar $cov \
        --threads 20 \
        --model-only --keep /home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Neuroimaging_samples/chrX.idlist \
        --out ${out}/similarity_${pheno}_GWAS_model_$i
$gcta64 --bfile /home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Neuroimaging_samples/ukbchr_v2_r2correct_X \
        --load-model ${out}/similarity_${pheno}_GWAS_model_${i}.fastGWA  \
        --geno 0.1 --out ${out}/similarity_${pheno}_GWAS_X_${i} --threads 20
$gcta64 --reml \
        --grm /home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Neuroimaging_samples/full_grm \
        --pheno ${pheno_path}/${pheno}_forGWAS.txt \
        --mpheno 3 \
        --reml-pred-rand \
        --qcovar $qcov --covar $cov \
        --threads 20 --out ${out}/similarity_${pheno}_GWAS_h2_${i}
python /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/python/py05_GWAS_auto_X.py \ 
       ${out}/similarity_${pheno}_GWAS_auto_${i}.fastGWA ${out}/similarity_${pheno}_GWAS_X_${i}.fastGWA ${out}/similarity_${pheno}_GWAS_${i}.txt
done
