#!/bin/python
import sys
import numpy as np
from scipy.io import loadmat
from scipy import stats
from brainsmash.mapgen.stats import spearmanr
from brainsmash.mapgen.stats import pearsonr
from brainsmash.mapgen.stats import nonparp

# calculate the overall distance between individual and template (UKB or HCP)

def spatial_similarity(name, individual, grad, method='pearson'):
  '''
  parameters
  ----------
  name: {'UKB','HCP'}
  individual: narray
      shape is (eigenvector, parcel)
  grad: int
      the number of eigenvector, starts from 1
  method: {'pearson', 'spearman'}
  '''
  null_models = loadmat('/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/null_modes/'+name+'_mmp.mat')[name+'_mmp']
  group_grad = np.loadtxt('/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/'+name+'_group_grad_mmp.txt')
  if method=='spearman':
    surrogate_corrs = spearmanr(individual[:,grad-1], null_models[grad-1]).flatten()
    r_stat = spearmanr(individual[:,grad-1], group_grad[:,grad-1])[0]
  elif method=='pearson':
    surrogate_corrs = pearsonr(individual[:,grad-1], null_models[grad-1]).flatten()
    r_stat = pearsonr(individual[:,grad-1], group_grad[:,grad-1])[0]
  p = nonparp(r_stat, surrogate_corrs)
  if p==0:
    p=0.0001
  z_crit = stats.norm.ppf(1-p/2) # 2-side
  return [r_stat[0],z_crit]

grad=int(sys.argv[2])
a = open('/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/overall_similarity/'+sys.argv[3], 'a+')

subdir=['grad_raw_mmp/','grad_refHCP_mmp/','grad_refUKB_mmp/']

individual= np.loadtxt('/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/'+subdir[0]+sys.argv[1])
simi_raw_HCP = spatial_similarity('HCP', individual, grad)
simi_raw_UKB = spatial_similarity('UKB', individual, grad)

individual= np.loadtxt('/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/'+subdir[1]+sys.argv[1])
simi_HCP = spatial_similarity('HCP', individual, grad)
individual= np.loadtxt('/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/'+subdir[2]+sys.argv[1])
simi_UKB = spatial_similarity('UKB', individual, grad)

a.write(sys.argv[1][3:10] + sys.argv[1][3:10] \
        ',' + str(simi_raw_HCP[0]) + ',' + str(simi_raw_HCP[1]) + \
        ',' + str(simi_raw_UKB[0]) + ',' + str(simi_raw_UKB[1]) + \
        ',' + str(simi_HCP[0]) + ',' + str(simi_HCP[1]) + \
        ',' + str(simi_UKB[0]) + ',' + str(simi_UKB[1]) + '\n')

a.close()