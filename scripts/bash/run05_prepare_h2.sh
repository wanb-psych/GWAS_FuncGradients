#!/bin/bash

###Run heritability
wd=/home/hpcwan1/rds/hpc-work/project/gwas_fg
for pheno in grad_refHCP_0.9 grad_refHCP_0.5 grad_refHCP_0.0; do
  for grad in {1..3}; do
    python ${wd}/scripts/python/py06_prepare_pheno_GWAS_region.py ${pheno} ${grad}
  done
done