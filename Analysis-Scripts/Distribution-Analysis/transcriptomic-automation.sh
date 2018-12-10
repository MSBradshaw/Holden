#!/bin/bash
for i in `seq 1 100`; do
	python3 Classification-first-second-general-use.py '../../Data/Distribution-Data-Set/train_transcriptomics_distribution'$i'.csv' '../../Data/Distribution-Data-Set/test_transcriptomics_distribution'$i'.csv' 'transcriptomics_results'$i'.png'

done
