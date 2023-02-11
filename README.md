# uex-slurm
This repository contains all the codes I have been using in slurm. The files with extension `.out` are not tracked. The use case is the fibonacci calculation given a maximum value.

## Job arrays
SLURM array jobs make it easy to run many similar tasks. You just have to run the following command in the terminal:
```
sbatch --array=0-2:1 launch_job_arrays.sh
```
This command will submit and add the job to the Slurm queue. I have included the `--array` option but the procedure is the same for any other option.

In this particular example, the array option is already included inside the bash file, so we only need:
```
sbatch launch_job_arrays.sh
```

## Job single
Run the following command:
```
sbatch launch_job_single.sh
```

## Basic Slurm commands
Show information about your job(s) in the queue. When run without the `-u, --user=<user_list>` option, shows a list of your job(s) and all other jobs in the queue.
```
squeue -u <user_id>
```

## Useful terminal commands
Delete every output file (careful):
```
rm *.out
```
