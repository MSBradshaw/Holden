#!/bin/bash
module load anaconda
pip install --user pandas==0.23.0
pip install --user mkl
for i in `seq 61 80`; do
    python3 Classification-first-and-second-general-use.py '../../Data/Distribution-Data-Set/CNA-100/train_cna_distribution'$i'.csv' '../../Data/Distribution-Data-Set/CNA-100/test_cna_distribution'$i'.csv' 'CNAResults/cna_results'$i'.csv'

done
