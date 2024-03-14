#!/bin/bash

workdir=/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/overall_similarity

for i in $(seq 1 10)
do 
  python ../python/py03_integrate_files.py $workdir variogram_z_g${i}
  echo "finish...variogram_z_g"${i}
  mv $workdir/variogram_z_g${i}_* /home/hpcwan1/rds/hpc-work/project/gwas_fg/tmp
done

for i in $(seq 0 9)
do
  mv $workdir/sub.out${i} /home/hpcwan1/rds/hpc-work/project/gwas_fg/tmp
done 