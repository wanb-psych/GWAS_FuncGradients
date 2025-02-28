#!/bin/python
import sys
import os
import numpy as np
import pandas as pd
import scipy.stats as ss
from scipy.spatial.distance import cosine

# calculate the overall distance between individual and template (UKB or HCP)
wd='/data/p_02378/UKB_cam/project/gwas_fg/'

subdir=sys.argv[1]+"/" # data input e.g., grad_refHCP_0.9
spa=subdir[12:15]
group_grad = np.loadtxt(wd+'data/HCP_group_grad_mmp_'+spa+'.txt')

# output
try:
    os.mkdir(wd+'results/cosine/')
    os.mkdir(wd+'results/cosine/'+subdir)
except:
    pass
try:  
    os.remove(wd+'results/cosine/'+subdir+'cosine.txt')
except:
    pass
    
a = open(wd+'results/cosine/'+subdir+'cosine.txt', 'w')

list_col = 'FID IID g1 g2 g3 g4 g5 g6 g7 g8 g9 g10'
list_col_n = 'FID IID r d'
for i in range(360):
  list_col_n = list_col_n + ' node_'+str(i+1)
a.write(list_col + '\n')
a.close()

path=wd+'data/'+subdir
path_list=os.listdir(path)
path_list.sort()
for i in range(len(path_list)):
    individual = np.loadtxt(path+path_list[i])
    d=[path_list[i][3:10], path_list[i][3:10]]
    e=[path_list[i][3:10], path_list[i][3:10]]
    for g in range(10):
      d.append(1-cosine(individual[:,g], group_grad[:,g]))
    d = np.array(d, dtype=str)
    d = ' '.join(d) + ' \n'
    a = open(wd+'results/cosine/'+subdir+'cosine.txt', 'a+')
    a.write(d)
    a.close()
    print(path_list[i][3:10])
  
data = pd.read_csv(wd+'results/cosine/'+subdir+'cosine.txt', sep=' ', index_col=False) 
data.to_csv(wd+'results/cosine/'+subdir+'cosine.txt', sep=' ', index=False) 
