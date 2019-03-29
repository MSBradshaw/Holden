#!/bin/bash

#SBATCH --time=10:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=8192M   # memory per CPU core
#SBATCH --mail-user=Michaelscottbradshaw@gmail.com   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# Compatibility variables for PBS. Delete if not needed.
export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=$SLURM_JOB_ID
export PBS_O_WORKDIR="$SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

module load anaconda
vals=($(seq -s ' ' 1 50))
for i in "${vals[@]}"
do
    echo  cna-random-$i
    python Classification-Optimized-General-Use.py ../../Data/Imputation-Data-Set/cna-50/CNA-imputation-train-$i.csv ../../Data/Imputation-Data-Set/cna-50/CNA-imputation-test-$i.csv imputation-cna-results/imputation-cna-results-$i.csv cna
done
tar -zcvf imputation-cna-results.tar.gz imputation-cna-results/ 
