#!/bin/bash
## Shebang.

## Resource request.
#SBATCH --nodes=1                                   ## Number of nodes.
#SBATCH --partition=volta                           ## Request specific partition.
#SBATCH --wait-all-nodes=1                          ## Controls when the execution begins.
#SBATCH --time=00:10:00                             ## Job duration (Sergio: 24:00:00).
#SBATCH --gpus-per-node=4                           ## Number of GPUs on each node (Sergio: 4).
#SBATCH --job-name=max_fibonacci_%A_%a              ## Name of the job.
#SBATCH --output=slurm_%A_%a.out                    ## Output file.
#SBATCH --mail-type=ALL				    ## (not working) Type of notification via email.
#SBATCH --mail-user=sfandres@unex.es                ## (not working) User to receive the email notification.
#SBATCH --array=10,100,1000                         ## Run job arrays (other options: =1-4:1 or =1-4%2).

## Catch Slurm environment variables.
job_id=${SLURM_ARRAY_JOB_ID}
task_id=${SLURM_ARRAY_TASK_ID}

## Create a string for email subject.
both_ids="job_id=${job_id} task_id=${task_id}"

## Send email when job begin (two options).
## cat email_body.txt | /usr/bin/mail -s "Sbatch ${both_ids} began" sfandres@unex.es
echo " " | /usr/bin/mail -s "Sbatch ${both_ids} began" sfandres@unex.es

## Load the Python module (not necessary).
## module load cuda/11.0.1

## Load virtual environment (not necessary).
## source ~/lulc/lulc-venv/bin/activate

## Execute the Python script and pass the arguments.
srun python3 max_fibonacci.py ${task_id}

## Send email when job ends.
cat slurm_${job_id}_${task_id}.out | /usr/bin/mail -s "Sbatch ${both_ids} ended" sfandres@unex.es
