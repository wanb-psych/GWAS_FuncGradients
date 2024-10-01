import pandas as pd
import numpy as np
import sys
import os

input=sys.argv[1] # grad_refHCP_0.0

wd='/home/hpcwan1/rds/hpc-work/project/gwas_fg/'

new=pd.DataFrame()

for i in range(1,11):
  df = pd.read_csv(wd+'results/similarity/'+input+'/g'+str(i)+'.txt', sep=' ')
  df.loc[df['z'] < 1.959964, 'r'] = np.nan
  new['g'+str(i)] = np.array(df.r)

new.insert(loc=0,column='FID',value=np.array(df.FID))
new.insert(loc=0,column='IID',value=np.array(df.IID))
new = new.fillna('NA')

try:
    os.mkdir(wd+'results/GWAS/similarity/'+input)
except:
    pass
new.to_csv(wd+'results/GWAS/similarity/'+input+'/pheno.txt', sep=' ', index=None)