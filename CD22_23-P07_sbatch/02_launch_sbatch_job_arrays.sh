#!/bin/bash
## Shebang.


## Resource request.
#SBATCH --nodes=1                                   ## Number of nodes.
#SBATCH --partition=cpu12c                          ## Request specific partition.
#SBATCH --mem=4GB                                   ## Real memory required per node.
#SBATCH --wait-all-nodes=1                          ## Controls when the execution begins.
#SBATCH --time=00:10:00                             ## Job duration.
#SBATCH --ntasks=1                                  ## Total number of tasks required.
#SBATCH --ntasks-per-node=1                         ## Number of tasks on each node.
#SBATCH --cpus-per-task=1                           ## Number of cpus required per task.
#SBATCH --mail-type=ALL                             ## (not working) Type of notification via email.
#SBATCH --mail-user=sfandres@unex.es                ## (not working) User to receive the email notification.
#SBATCH --job-name=max_fibonacci_%A_%a              ## Name of the job.
#SBATCH --output=slurm_%A_%a.out                    ## Output file.
#SBATCH --array=10,100,1000                         ## Run job arrays (other options: =1-4:1 or =1-4%2).


## Catch Slurm environment variables.
job_id=${SLURM_ARRAY_JOB_ID}
task_id=${SLURM_ARRAY_TASK_ID}

## Create a string for email subject.
both_ids="job_id=${job_id} task_id=${task_id}"

## Send email when job begin.
echo " " | /usr/bin/mail -s "Sbatch ${both_ids} began" sfandres@unex.es

## Load the Python module (newest version available).
module load python/3.9.10

## Load environments (not necessary here).
## Option 1: Load Python venv environment.
## source ~/path_to_venv_folder/bin/activate
## Option 2: Load Anaconda environment.
## source ~/anaconda3/etc/profile.d/conda.sh
## conda activate env_name

## Execute the Python script and pass the arguments.
srun python3 ../max_fibonacci.py -m ${task_id}

## Send email when job ends.
cat slurm_${job_id}_${task_id}.out | /usr/bin/mail -s "Sbatch ${both_ids} ended" sfandres@unex.es
