# slurm
This repository contains all the codes I have been using in slurm.

## Usage
Run the following command in the terminal:
```
sbatch --array=0-2:1 launch_sbatch.sh
```
This command will submit and add the job to the Slurm queue. I have included the `--array` option but the procedure is the same for any other option.

In this particular example, the array option is already included inside the bash file, so we only need:
```
sbatch launch_sbatch.sh
```

## Useful terminal commands
Delete every output file (careful):
```
rm *.out
```
