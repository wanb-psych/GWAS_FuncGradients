#!/bin/python

from brainsmash.mapgen.base import Base
import numpy as np
from scipy.io import savemat
import sys

name = sys.argv[1] # 'HCP' or 'UKB'
sparsity = sys.argv[2] # '0.0' or '0.5' or '0.9'

wd='/home/hpcwan1/rds/hpc-work/project/gwas_fg/'
brain_map_file = wd + 'data/'+name+'_group_grad_mmp_'+sparsity+'.txt'
dist_mat_file_L = wd + 'src/LeftParcelGeodesicDistmat.txt'
dist_mat_file_R = wd + 'src/RightParcelGeodesicDistmat.txt'

# generate 10000 permutations for 10 gradients
base_L = [None] * 10 
base_R = [None] * 10 
surrogates = [None] * 10
for i in range(10):
  base_L[i] = Base(x=np.loadtxt(brain_map_file)[:,i][:180], D=dist_mat_file_L, kernel='gaussian', pv=25, nh=30, seed=0)
  base_R[i] = Base(x=np.loadtxt(brain_map_file)[:,i][180:], D=dist_mat_file_R, kernel='gaussian', pv=25, nh=30, seed=0)
  surrogates_L = base_L[i](n=10000)
  surrogates_R = base_R[i](n=10000)
  surrogates[i] = np.concatenate((surrogates_L, surrogates_R),axis=1)
  print('finish......gradient...'+str(i+1))

savemat(wd+'results/null_modes/'+name+'_'+sparsity+'.mat', {name+'_'+sparsity:np.array(surrogates)})
print('finish......',name,sparsity)
