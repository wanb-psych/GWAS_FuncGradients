# Genetic, transcriptomic, metabolic, and neuropsychiatric underpinnings of cortical functional gradients

This repo is for documentation of the work
---
Preprint: https://doi.org/10.1101/2025.03.03.25323242  

### $ python

- `py00`: generating individual gradients using different sparsity scores, which are aligned to HCP group-level gradients.

- `py01`: generating null group-level gradients by variogram, based on the HCP group-level geometric distance.

- `py02`: cosine similarity, Euclidean distance, and Pearson r, between individual gradients and HCP group-level.

- `py03`: integrating these scores from py03 into one file.

- `py04`: preparing phenotype files (global-level) for the heritability analysis and GWAS.

- `py05`: combining autochromosome and sexual chromosome results (because GWAS performed them separately) and filtering the MAF<0.1%.

- `py06`: preparing phenotype files (region-level) for the heritability analysis and GWAS.

- `py07`: imputing the missing gene expression, Allen Human Brain Atlas (AHBA), for Glasser parcellation, based on variogram of center coordinates of each parcel in volumetric space.

- `visualization`: generating all figures and other statistics in the paper.

- `twin genetics`: using the previous code from my repos (https://github.com/CNG-LAB/cngopen/tree/main/asymmetry_functional_gradients, https://github.com/wanb-psych/microstructural_asymmetry/blob/main/run_solar.sh)

### $ bash

- `run00-03,05`: working with python scripts and slurm using the high-performance computing service.

- `run04`: GWAS code for gradients using GCTA64.

- `run06`: extracting heritability scores from GCTA64 output.

### $ r

- `manhtn`: Manhattan plots for GWAS summaries using R package "CMplot".


## Key toolboxes
- Brainspace (https://brainspace.readthedocs.io/en/latest/index.html)

- BrainSMASH (https://brainsmash.readthedocs.io/en/latest/)

- statsmodels (https://www.statsmodels.org/stable/index.html)

- GCTA64 (https://yanglab.westlake.edu.cn/software/gcta/)

- abagen (https://abagen.readthedocs.io/en/stable/)

- SOLAR (https://solar-eclipse-genetics.org/)


## Correspondence
Bin Wan (binwan.academic[at]gmail.com)  
Sofie L. Valk (valk[at]cbs.mpg.de)  

Neurobiosocial (NBS) & Cognitive Neurogenetics (CNG) lab,   
Max Planck Institute for Human Cognitive and Brain Sciences &  
Institute of Neuroscience and Medicine (INM-7), Research Centre Jülich 
