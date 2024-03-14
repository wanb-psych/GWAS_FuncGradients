import pandas as pd
import sys

input_1=sys.argv[1]
input_2=sys.argv[2]
output=sys.argv[3]
autosome=pd.read_csv(input_1, sep='\t')
xsome=pd.read_csv(input_2, sep='\t')
  
new=pd.concat([autosome, xsome])
new.to_csv(output, sep=',', index=None)