#!/bin/bash
module load anaconda
pip install --user pandas==0.23.0
pip install --user mkl
for i in `seq 1 100`; do
    python3 Classification-first-and-second-general-use.py '../../Data/Random-Data-Set/CNA-100/train_cna_random'$i'.csv' '../../Data/Random-Data-Set/CNA-100/test_cna_random'$i'.csv' 'CNAResults/cna_results'$i'.csv'

done
