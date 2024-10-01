#!/bin/bash

plink=/home/hpcwan1/rds/hpc-work/software/plink_20231211/plink
out=/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/MAF
genes=/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Neuroimaging_samples/ukbchr_v2_r2correct_v2
genes_x=/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/genetics_data/Neuroimaging_samples/ukbchr_v2_r2correct_X

# plink --file your_data.bed your_data.bim your_data.fam --freq

for i in {1..22}
do
  $plink --bfile ${genes}_${i} --allow-no-vars \
         --freq --out ${out}/MAF_ukb_v2_r2correct_v2_${i}
done

$plink --bfile ${genes_x} --allow-no-vars \
       --freq --out ${out}/MAF_ukb_v2_r2correct_v2_X

