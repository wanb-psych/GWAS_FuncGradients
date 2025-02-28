#!/bin/bash

# e.g., grad_refHCP_0.9 and 1 (gradient 1)
wdir=${1}
#mode=${2}
#path=/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/GWAS/similarity
path=/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/distance

#output=${path}/${wdir}/${wdir}_region_g${mode}_h2r.txt
output=${path}/${wdir}/${wdir}_region_distance_h2r.txt
echo "node,H2r,SE,p" > $output
for i in {1..360}; do
  #cur_dir=${path}/${wdir}/region_g${mode}/node_$i
  cur_dir=${path}/${wdir}/region_$i
  #line=`more ${cur_dir}/${wdir}_h2_node_${i}.hsq | grep "V(G)/Vp"`
  line=`more ${cur_dir}/h2_node_${i}.hsq | grep "V(G)/Vp"`
  H2r=`echo $line |  awk '{print $2}'`
  SE=`echo $line |  awk '{print $3}'`
  #line2=`more ${cur_dir}/${wdir}_h2_node_${i}.hsq | grep "Pval"`
  line2=`more ${cur_dir}/h2_node_${i}.hsq | grep "Pval"`
  p=`echo $line2 |  awk '{print $2}'`
  echo node_${i},${H2r},${SE},${p}
  echo node_${i},${H2r},${SE},${p} >> $output
done
