#!/bin/bash

#SBATCH --time=10:00:00   # walltime
#SBATCH --ntasks=12   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=65536M   # memory per CPU core
#SBATCH --mail-user=michaelscottbradshaw@gmail.com   # email address
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

for i in `seq 1 5`; do
    bash 'proteomic-automation'$i'.sh' &
    bash 'transcriptomic-automation'$i'.sh' &
done

wait
