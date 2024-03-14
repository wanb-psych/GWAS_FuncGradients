import pandas as pd
import numpy as np
import sys

align_type=sys.argv[1] # 'r_raw_HCP', 'r_raw_UKB', 'r_HCP', 'r_UKB'
grad=sys.argv[2] # 1,2,3 indicate 'g1', 'g2', 'g3'

df = pd.read_csv('/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/overall_similarity/variogram_z_g'+str(grad)+'_forGWAS.txt', sep=' ')
df_raw = pd.read_csv('/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/overall_similarity/variogram_z_g'+str(grad)+'.txt', sep=' ')
df_type = df[['FID','IID',align_type]]

if align_type == 'r_HCP':
    indi_grad = '/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/grad_refHCP_mmp/'
elif align_type == 'r_UKB':
    indi_grad = '/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/grad_refUKB_mmp/'
else:
    indi_grad = '/home/hpcwan1/rds/hpc-work/project/gwas_fg/data/grad_raw_mmp/'

df_new = df_type.fillna('NA')
node_list=[]
for node in range(360):
  node_list.append('node_'+str(node+1))

data = np.zeros((len(df_new.IID), 360))
for sub in range(len(df_new.IID)):
    tmp = np.loadtxt(indi_grad+'UKB'+str(df_new.IID[sub])+'.txt')[:,int(grad)-1]
    if df_raw[align_type][np.where(df_raw.IID == df_new.IID[sub])[0][0]] < 0: # flip gradients if negative
        data[sub] = -tmp
    else:
        data[sub] = tmp
        
df_data=pd.DataFrame(data)
df_data.columns = node_list

df_save = pd.concat([df_new, df_data], axis=1)

df_save.to_csv('/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/GWAS/region_g'+str(grad)+'/'+align_type+'_forGWAS.txt', 
               index=None, sep=' ')