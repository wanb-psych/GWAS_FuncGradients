import pandas as pd
import numpy as np
from pykrige.uk3d import UniversalKriging3D

allen = pd.read_csv('../../data/allgenes_stable_r-1_glasser_360.csv')[:360]
allen_imputed = pd.DataFrame()
allen_imputed['label'] = 	allen['label']
coordinate = pd.read_csv('../../src/HCP-MMP1_UniqueRegionList.csv')
gene_list = allen.columns[1:]
for i in range(len(gene_list)):
  name = gene_list[i]
  tmp = pd.DataFrame()
  tmp['x'] = np.array(coordinate['x-cog']).copy()
  tmp['y'] = np.array(coordinate['y-cog']).copy()
  tmp['z'] = np.array(coordinate['z-cog']).copy()
  tmp['gene_expression'] = np.array(allen[name]).copy()
  known_data = tmp.dropna(subset=['gene_expression'])
  missing_data = tmp[tmp['gene_expression'].isna()]
  uk = UniversalKriging3D(
    known_data['x'],  # x-coordinates
    known_data['y'],  # y-coordinates
    known_data['z'],  # z-coordinates
    known_data['gene_expression'],  # Known values (dependent variable)
    variogram_model='linear',  # Variogram model
    verbose=False,  # Disable verbose output
    enable_plotting=False)  # Disable variogram plotting
  missing_values, ss = uk.execute(
    'points',  # Interpolation type ('points' for individual locations)
    missing_data['x'],  # x-coordinates of missing data
    missing_data['y'],  # y-coordinates of missing data
    missing_data['z'])   # z-coordinates of missing data)
  tmp.loc[tmp['gene_expression'].isna(), 'gene_expression'] = missing_values
  allen_imputed[name] = np.array(tmp['gene_expression']).copy()
  print(i, name)

allen_imputed.to_csv('../../data/allgenes_stable_r-1_glasser_360_imputed.csv', index=None)