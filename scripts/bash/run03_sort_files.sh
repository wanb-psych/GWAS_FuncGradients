#!/bin/bash

wd=/home/hpcwan1/rds/hpc-work/project/gwas_fg

for pheno in grad_refHCP_0.0 grad_refHCP_0.5 grad_refHCP_0.9; do
    python ${wd}/scripts/python/py04_prepare_pheno_GWAS.py ${pheno}
done