import pandas as pd
import numpy as np
import sys

input_1=sys.argv[1]
input_2=sys.argv[2]
output=sys.argv[3]
maf=sys.argv[4]
autosome=pd.read_csv(input_1, sep='\t')
xsome=pd.read_csv(input_2, sep='\t')

frq_path='/home/hpcwan1/rds/hpc-work/project/gwas_fg/results/MAF/MAF_ukb_v2_r2correct_v2_'

snp_maf = []
for i in range(22):
  frq=np.loadtxt(frq_path+str(i+1)+'.frq',dtype=str)[1:,4].astype(float)
  snp=np.loadtxt(frq_path+str(i+1)+'.frq',dtype=str)[1:,1]
  snp_maf.append(snp[frq>np.float64(maf)])
  print(i+1)

frq_x=np.loadtxt(frq_path+'X.frq',dtype=str)[1:,4].astype(float)
snp_x=np.loadtxt(frq_path+'X.frq',dtype=str)[1:,1]
snp_x_maf = snp_x[frq_x>np.float64(maf)]
print('x')

mask_auto = autosome['SNP'].isin(np.concatenate(snp_maf))
mask_x = xsome['SNP'].isin(np.array(snp_x_maf))

print('generating GWAS with MAF')
new=pd.concat([autosome[mask_auto], xsome[mask_x]])
print(len(new))
new.to_csv(output, sep=',', index=None)