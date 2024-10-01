import pandas as pd
import numpy as np
import sys
import os

spa=sys.argv[1] # 'grad_refHCP_0.0', 'grad_refHCP_0.5', 'grad_refHCP_0.9'
grad=sys.argv[2] # 1,2,3 indicate 'g1', 'g2', 'g3'
wd='/home/hpcwan1/rds/hpc-work/project/gwas_fg/'

df = pd.read_csv(wd+'results/similarity/'+spa+'/g'+grad+'.txt', sep=' ')
df = df[df.columns[:4]]
indi_grad = wd+'data/'+spa

node_list=[]
for node in range(360):
  node_list.append('node_'+str(node+1))

data = np.zeros((len(df.IID), 360))
for sub in range(len(df.IID)):
    tmp = np.loadtxt(indi_grad+'/UKB'+str(df.IID[sub])+'.txt')[:,int(grad)-1]
    data[sub] = tmp
    
data[np.isnan(df.r)] = np.nan
        
df_data=pd.DataFrame(data)
df_data.columns = node_list
df_data = df_data.fillna('NA')

df_save = pd.concat([df, df_data], axis=1)

try:
    os.mkdir(wd+'results/GWAS/similarity/'+spa+'/region_g'+str(grad))
except:
    pass

df_save.to_csv(wd+'results/GWAS/similarity/'+spa+'/region_g'+str(grad)+'/pheno.txt', 
               index=None, sep=' ')

print('finish...', spa, '...gradient', grad)