#!/bin/bash
for i in `seq 1 5`; do
    bash 'proteomic-automation'$i'.sh' & 
    bash 'transcriptomic-automation'$i'.sh' &
done
