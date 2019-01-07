#!/bin/bash
for i in `seq 1 100`; do
    python3 results-plotter.py 'transcriptomic_results/transcriptomics_results'$i'.csv' 'transcriptomic-results-plot'$i'.png'
done
