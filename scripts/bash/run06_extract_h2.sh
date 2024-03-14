#!/bin/bash

# e.g., r_HCP and 1 (gradient 1)
wdir=${1}
mode=${2}
path=/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/GWAS

output=${path}/${wdir}_region_g${mode}_h2r.txt
echo "node,H2r,SE,p" > $output
for i in {1..360}; do
  cur_dir=${path}/region_g${mode}/node_$i
  line=`more ${cur_dir}/${wdir}_h2_node_${i}.hsq | grep "V(G)/Vp"`
  H2r=`echo $line |  awk '{print $2}'`
  SE=`echo $line |  awk '{print $3}'`
  line2=`more ${cur_dir}/${wdir}_h2_node_${i}.hsq | grep "Pval"`
  p=`echo $line2 |  awk '{print $2}'`
  echo node_${i},${H2r},${SE},${p}
  echo node_${i},${H2r},${SE},${p} >> $output
done
