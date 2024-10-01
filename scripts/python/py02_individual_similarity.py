#!/bin/python
import sys
import os
import numpy as np
from scipy.io import loadmat
from scipy import stats
from brainsmash.mapgen.stats import spearmanr
from brainsmash.mapgen.stats import pearsonr
from brainsmash.mapgen.stats import nonparp

# calculate the overall distance between individual and template (UKB or HCP)
wd='/home/hpcwan1/rds/hpc-work/project/gwas_fg/'

subdir=sys.argv[1]+"/" # data input e.g., grad_refHCP_0.0
grad=int(sys.argv[2]) # gradient number e.g., 1, 2, 3, ect

def spatial_similarity(name, spa, individual, grad, method='pearson'):
  '''
  parameters
  ----------
  name: {'UKB','HCP'}
  spa: {'0.0','0.5','0.9'}
  individual: narray
      shape is (eigenvector, parcel)
  grad: int
      the number of eigenvector, starts from 1
  method: {'pearson', 'spearman'}
  '''
  null_models = loadmat(wd+'results/null_modes/'+name+'_'+spa+'.mat')[name+'_'+spa]
  group_grad = np.loadtxt(wd+'data/'+name+'_group_grad_mmp_'+spa+'.txt')
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

# output
try:
    os.mkdir(wd+'results/similarity/'+subdir)
except:
    pass

a = open(wd+'results/similarity/'+subdir+'g'+str(grad)+'.txt', 'w')
a.write('FID IID r z \n')
a.close()

path=wd+'data/'+subdir
path_list=os.listdir(path)
path_list.sort()
for i in range(len(path_list)):
    individual= np.loadtxt(path+path_list[i])
    simi = spatial_similarity('HCP', sys.argv[1][12:], individual, grad)
    a = open(wd+'results/similarity/'+subdir+'g'+str(grad)+'.txt', 'a+')
    a.write(path_list[i][3:10] + ' ' + path_list[i][3:10] + ' ' + str(simi[0]) + ' ' + str(simi[1]) + ' \n')
    a.close()