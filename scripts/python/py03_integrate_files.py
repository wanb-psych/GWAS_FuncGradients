import pandas as pd
import sys

workdir=sys.argv[1]
file_name=sys.argv[2]
output=workdir+'/'+file_name+'.txt'
df = [None] * 10
for i in range(10):
  df[i] = pd.read_csv(workdir+'/'+file_name+'_'+str(i)+'.txt')
  
new=pd.concat(df)
new.to_csv(output, index=None)