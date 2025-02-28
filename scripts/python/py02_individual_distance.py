#!/bin/python
import sys
import os
import numpy as np
import scipy.stats as ss
from scipy.spatial import distance

# calculate the overall distance between individual and template (UKB or HCP)
wd='/home/hpcwan1/rds/hpc-work/project/gwas_fg/'

subdir=sys.argv[1]+"/" # data input e.g., grad_refHCP_0.9
spa=subdir[12:15]
group_grad = np.loadtxt(wd+'data/HCP_group_grad_mmp_'+spa+'.txt')
ref_e = np.sqrt((group_grad[:,:3]**2).sum(1))

# output
try:
    os.mkdir(wd+'results/distance/'+subdir)
except:
    pass
  
try:
    os.mkdir(wd+'results/ecce/'+subdir)
except:
    pass

a = open(wd+'results/distance/'+subdir+'euclidean_distance.txt', 'w')
b = open(wd+'results/ecce/'+subdir+'eccentricity.txt', 'w')

list_col = 'FID IID g1 g2 g3 g4 g5 g6 g7 g8 g9 g10'
list_col_n = 'FID IID r d'
for i in range(360):
  list_col_n = list_col_n + ' node_'+str(i+1)
a.write(list_col + '\n')
a.close()

b.write(list_col_n + '\n')
b.close()

path=wd+'data/'+subdir
path_list=os.listdir(path)
path_list.sort()
for i in range(len(path_list)):
    individual = np.loadtxt(path+path_list[i])
    d=[path_list[i][3:10], path_list[i][3:10]]
    e=[path_list[i][3:10], path_list[i][3:10]]
    for g in range(10):
      d.append(distance.euclidean(individual[:,g], group_grad[:,g]))
    d = np.array(d, dtype=str)
    d = ' '.join(d) + ' \n'
    a = open(wd+'results/distance/'+subdir+'euclidean_distance.txt', 'a+')
    a.write(d)
    a.close()
    
    tmp = np.sqrt((individual[:,:3]**2).sum(1))
    r_tmp = [ss.pearsonr(tmp, ref_e)[0]]
    d_tmp = [distance.euclidean(tmp, ref_e)]
    e = np.concatenate((e, r_tmp,d_tmp,tmp),dtype=str)
    e = ' '.join(e) + ' \n'
    b = open(wd+'results/ecce/'+subdir+'eccentricity.txt', 'a+')
    b.write(e)
    b.close()
    
    print(path_list[i][3:10])
    
data = pd.read_csv(wd+'results/distance/'+subdir+'euclidean_distance.txt', sep=' ', index_col=False) 
data.to_csv(wd+'results/distance/'+subdir+'euclidean_distance.txt', sep=' ', index=False)   
data = pd.read_csv(wd+'results/ecce/'+subdir+'eccentricity.txt', sep=' ', index_col=False) 
data.to_csv(wd+'results/ecce/'+subdir+'eccentricity.txt', sep=' ', index=False)  