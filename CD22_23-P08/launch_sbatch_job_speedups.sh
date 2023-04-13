#!/bin/bash
## Shebang.


## Resource request.
#SBATCH --nodes=1                                   ## Number of nodes.
#SBATCH --partition=cpu12c                          ## Request specific partition.
#SBATCH --wait-all-nodes=1                          ## Controls when the execution begins.
#SBATCH --time=00:30:00                             ## Job duration.
#SBATCH --mail-type=ALL                             ## (not working) Type of notification via email.
#SBATCH --mail-user=sfandres@unex.es                ## (not working) User to receive the email notification.
#SBATCH --job-name=reduction_%A                     ## Name of the job.
#SBATCH --output=slurm_%A.out                       ## Output file.

#SBATCH --exclusive                                 ## Job allocation can not share nodes with other running jobs.
#SBATCH --mem=0                                     ## Real memory required per node (0: request all the memory on a node).
#SBATCH --ntasks=1                                  ## Total number of tasks required.
#SBATCH --ntasks-per-node=1                         ## Number of tasks on each node.
#SBATCH --cpus-per-task=12                          ## Number of cpus required per task on a node.
#SBATCH --ntasks-per-socket=1                       ## Request the maximum ntasks be invoked on each socket.
#SBATCH --cores-per-socket=6                        ## Restrict node selection to nodes with at least the specified number of cores per socket.
#SBATCH --threads-per-core=1                        ## Restrict node selection to nodes with at least the specified number of threads per core.
#SBATCH --nodelist=dap101                           ## Request a specific list of hosts.


## Catch Slurm environment variables.
job_id=${SLURM_JOB_ID}

# Get the parameter from the command-line argument.
if [ $# -eq 1 ]; then
    num_threads=$1
else
    num_threads=1
fi
echo "Number of threads: $num_threads"

## Send email when job begin.
echo " " | /usr/bin/mail -s "Sbatch job_id=${job_id} began" sfandres@unex.es

## Compile on the compilation node.
echo " "
srun -p compile -N 1 -n 1 -t 00:10:00 make
echo " "

## Parameters.
num_rows=100000
num_features=100

## Execute the Python script and pass the arguments.
srun ./reduction \
${num_rows} \
${num_features} \
${num_threads}

## Send email when job ends.
cat slurm_${job_id}.out | /usr/bin/mail -s "Sbatch job_id=${job_id} ended" sfandres@unex.es
