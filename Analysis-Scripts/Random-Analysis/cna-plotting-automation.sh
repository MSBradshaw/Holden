#!/bin/bash
for i in `seq 1 100`; do
    python3 general-use-result-plotter.py 'CNAResults/cna_results'$i'.csv' 'CNAResults/cna-results-plot'$i'.png' 'Resampling Test CNA Accuracy'
done
