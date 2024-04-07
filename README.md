<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![LinkedIn][linkedin-shield]][linkedin-url]

# UEx-Slurm
This repository has been created for the Slurm lab session of the Distributed Computing subject at the University of Extremadura (UEx).

## Table of contents
* [Getting started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
  * [Usage](#usage)
* [Code examples](#code-examples)
* [Useful terminal commands](#useful-terminal-commands)
* [License](#license)

## Getting started

### Prerequisites
* Anaconda distribution is recommended to work with Python scripts. You can install it following the [official installation guide][anaconda].
* You need access to a supercomputer that uses the [Slurm workload manager][slurm].

### Installation
Not necessary.

### Usage

The files with extension `.out` are not tracked. The use case is the fibonacci calculation given a maximum value in Python for the first two examples, and measuring the speedup achieved in computing the mean value given a dataset and different number of threads in C++ for the third example.

#### [P06_srun](P06_srun)

To execute this example, you can run any of the following commands (which are saved inside the [launch_srun_job.sh](P06_srun/launch_srun_job.sh) file) on a Slurm-managed cluster.

```
srun -p cpu12c -N 1 -n 1 -J max_fibonacci -t 00:10:00  python3 ../max_fibonacci.py
srun --partition=cpu12c --nodes=1 --ntasks=1 --job-name=max_fibonacci --time=00:10:00 python3 ../max_fibonacci.py
```

```
usage: max_fibonacci.py [-h] [--maximum MAXIMUM]

Python script to play with slurm.

optional arguments:
  -h, --help            show this help message and exit
  --maximum MAXIMUM, -m MAXIMUM
                        input number to compute Fibonacci (>0).
```

#### [P07_sbatch](P07_sbatch)

To launch a single job with sbatch for the fibonacci computation, run the following command:
```
sbatch 01_launch_sbatch_job.sh
```

To run many similar tasks, it is better to use Slurm array jobs. You just have to run the following command in the terminal:
```
sbatch --array=0-2:1 <launch_script>.sh
```
This command will submit and add the job to the Slurm queue. I have included the `--array` option but the procedure is the same for any other option.

In this particular example, the array option is already included inside the bash file, so we only need:
```
sbatch 02_launch_sbatch_job_arrays.sh
```

#### [P08_speedup](P08_speedup)

Run the following command to execute the example:
```
sbatch launch_sbatch_job_speedups.sh <num_threads>
```
where `<num_threads>` is the desired number of threads that will be used for the parallel execution of the algorithm.

## Code examples
The examples are organized in folders:
* [P06_srun](P06_srun) contains a simple example of how to submit a single job to Slurm using `srun` with a Python script. 
* [P07_sbatch](P07_sbatch) contains a more complex example where `sbatch` is used to submit a single job first, followed by job arrays, where the script is also written in Python.
* [P08_speedup](P08_speedup) contains an example to measure speedups where the aim is to compute the mean value given a dataset of N rows and M features. The sbatch file executes the compilation process as well as the execution of the algorithm. The scripts are written in C++ for timing purposes.

## Useful terminal commands
Show information about your job(s) in the queue. When run without the `-u, --user=<user_list>` option, shows a list of your job(s) and all other jobs in the queue.
```
squeue -u <user_id>
```

## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
[linkedin-url]: https://linkedin.com/in/sfandres
[slurm]: https://slurm.schedmd.com/documentation.html
[anaconda]: https://docs.anaconda.com/anaconda/install/linux/
