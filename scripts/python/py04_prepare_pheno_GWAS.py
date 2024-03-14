import pandas as pd
import numpy as np
import sys

input=sys.argv[1]
output=sys.argv[2]
df = pd.read_csv(input, sep=' ')

df.r_raw_HCP = abs(df.r_raw_HCP)
df.r_raw_UKB = abs(df.r_raw_UKB)
df.r_HCP = abs(df.r_HCP)
df.r_UKB = abs(df.r_UKB)

df.r_raw_HCP[df.z_raw_HCP < 1.959964] = np.nan
df.r_raw_UKB[df.z_raw_UKB < 1.959964] = np.nan
df.r_HCP[df.z_HCP < 1.959964] = np.nan
df.r_UKB[df.z_UKB < 1.959964] = np.nan
 
new=pd.DataFrame()
new['FID'] = df.FID
new['IID'] = df.IID
new['r_raw_HCP'] = df.r_raw_HCP
new['r_raw_UKB'] = df.r_raw_UKB
new['r_HCP'] = df.r_HCP
new['r_UKB'] = df.r_UKB

new = new.fillna('NA')

new.to_csv(output, sep=' ', index=None)