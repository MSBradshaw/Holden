#!/bin/bash
module load anaconda
pip install --user pandas==0.23.0
pip install --user mkl
for i in `seq 81 100`; do
    python3 Classification-first-and-second-general-use.py '../../Data/Distribution-Data-Set/Proteomics-100/train_proteomics_distribution'$i'.csv' '../../Data/Distribution-Data-Set/Proteomics-100/test_proteomics_distribution'$i'.csv' 'ProteomicsResults/proteomics_results'$i'.csv'

done
