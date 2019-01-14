#!/bin/bash
module load anaconda
pip install --user pandas==0.23.0
pip install --user mkl
for i in `seq 61 80`; do
    python3 Classification-first-and-second-general-use.py '../../Data/Random-Data-Set/Proteomics-100/train_proteomics_random'$i'.csv' '../../Data/Random-Data-Set/Proteomics-100/test_proteomics_random'$i'.csv' 'ProteomicsResults/proteomics_results'$i'.csv'

done
