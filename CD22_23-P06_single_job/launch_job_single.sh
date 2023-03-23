#!/bin/bash
## Shebang.

## Resource request.
#SBATCH --nodes=1                                   ## Number of nodes.
#SBATCH --partition=volta                           ## Request specific partition.
#SBATCH --wait-all-nodes=1                          ## Controls when the execution begins.
#SBATCH --time=00:10:00                             ## Job duration (Sergio: 24:00:00).
## #SBATCH --gpus-per-node=4                           ## Number of GPUs on each node (Sergio: 4).
#SBATCH --ntasks-per-node=8			    ## Number of cpus on each node. 
#SBATCH --job-name=max_fibonacci_%A                 ## Name of the job.
#SBATCH --output=slurm_%A.out                       ## Output file.
#SBATCH --mail-type=ALL				    ## (not working) Type of notification via email.
#SBATCH --mail-user=sfandres@unex.es                ## (not working) User to receive the email notification.

## Catch Slurm environment variables.
job_id=${SLURM_JOB_ID}

## Send email when job begin.
echo " " | /usr/bin/mail -s "Sbatch job=${job_id} began" sfandres@unex.es

## Load the Python module (not necessary).
## module load cuda/11.0.1

## Load environments (not necessary here).

## Option 1: Load Python venv environment.
## source ~/path_to_venv_folder/bin/activate

## Option 2: Load Anaconda environment.
## source ~/anaconda3/etc/profile.d/conda.sh
## conda activate env_name

## Execute the Python script and pass the arguments.
srun reduction \
100000 \
100 \
10000

## Send email when job ends.
cat slurm_${job_id}.out | /usr/bin/mail -s "Sbatch job=${job_id} ended" sfandres@unex.es
