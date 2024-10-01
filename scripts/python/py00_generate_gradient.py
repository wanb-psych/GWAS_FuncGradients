import numpy as np
import os
from brainspace.gradient import GradientMaps
import sys

sparsity=float(sys.argv[1]) #0, 0.5, 0.9

hcp_fc = np.loadtxt('../../data/HCP_FC_groupmean_mmp.csv', delimiter=',')

gm_hcp = GradientMaps(kernel='normalized_angle', approach='dm', n_components=10, random_state=0)
gm_hcp.fit(hcp_fc, sparsity=sparsity)

np.savetxt('../../data/HCP_group_grad_mmp_'+str(sparsity)+'.txt', gm_hcp.gradients_)
np.savetxt('../../data/HCP_group_grad_mmp_lambdas'+str(sparsity)+'.txt', gm_hcp.lambdas_)

try:
    os.mkdir('../../data/grad_refHCP_'+str(sparsity)+'/')
except:
    pass

path = '../../data/fc_mmp/'
path_list = os.listdir(path)
path_list.sort()

for i in range(len(path_list)):
    sub_fc = np.loadtxt(path+path_list[i])
    gm_sub = GradientMaps(kernel='normalized_angle', approach='dm', n_components=10, random_state=0,
                          alignment='procrustes')
    gm_sub.fit(sub_fc, reference=gm_hcp.gradients_, sparsity=sparsity)
    np.savetxt('../../data/grad_refHCP_'+str(sparsity)+'/'+path_list[i], gm_sub.aligned_)


