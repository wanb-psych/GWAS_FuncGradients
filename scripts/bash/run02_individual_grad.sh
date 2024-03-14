#!/bin/bash

datadir=/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/grad_refHCP_mmp
workdir=/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/overall_similarity

rm -rf ${workdir}/sub.out
for i in `ls -v $datadir`; do echo $i >> ${workdir}/sub.out; done
split -n l/10 -da 1 ${workdir}/sub.out ${workdir}/sub.out

for j in $(seq 1 10)
do 
  for i in $(seq -w 0 9)
  do
    echo 'FID,IID,r_raw_HCP,z_raw_HCP,r_raw_UKB,z_raw_UKB,r_HCP,z_HCP,r_UKB,z_UKB' > ${workdir}/variogram_z_g${j}_${i}.txt
    sbatch /home/hpcwan1/rds/hpc-work/project/gwas_fg/scripts/bash/slurm02_individual.slurm ${workdir}/sub.out${i} ${j} variogram_z_g${j}_${i}.txt
  done 
done