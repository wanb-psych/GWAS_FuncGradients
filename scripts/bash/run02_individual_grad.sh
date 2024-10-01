#!/bin/bash

for i in {1..10}; do
  for type in 0.0 0.5 0.9; do
    sbatch slurm02_individual.slurm grad_refHCP_$type $i
  done
done