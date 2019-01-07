#!/bin/bash
for i in `seq 1 100`; do
    python3 results-plotter.py 'TranscriptomicsResults/transcriptomics_results'$i'.csv' 'TranscriptomicsResults/transcriptomic-results-plot'$i'.png'
done
