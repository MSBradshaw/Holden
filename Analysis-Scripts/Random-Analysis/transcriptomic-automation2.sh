#!/bin/bash
module load anaconda
pip install --user pandas==0.23.0
pip install --user mkl
for i in `seq 21 40`; do
    python3 Classification-first-and-second-general-use.py '../../Data/Distribution-Data-Set/Transcriptomics-100/train_transcriptomics_distribution'$i'.csv' '../../Data/Distribution-Data-Set/Transcriptomics-100/test_transcriptomics_distribution'$i'.csv' 'TranscriptomicsResults/transcriptomics_results'$i'.csv'

done
