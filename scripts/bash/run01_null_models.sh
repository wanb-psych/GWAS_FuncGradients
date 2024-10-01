#!/bin/bash

for i in 0.0 0.5 0.9;
  do sbatch slurm01_null_model.slurm HCP $i
done