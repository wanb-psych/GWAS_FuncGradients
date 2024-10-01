#!/bin/bash

wd=/home/hpcwan1/rds/hpc-work/project/gwas_fg
i=grad_refHCP_0.0
g=3  
for n in {1..360}; do
  sbatch ${wd}/scripts/bash/slurm04_region_h2.slurm $i $g $n
done