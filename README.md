<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![LinkedIn][linkedin-shield]][linkedin-url]

# uex-slurm
This repository contains all the codes I have been using in slurm. The files with extension `.out` are not tracked. The use case is the fibonacci calculation given a maximum value.

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
No necessary.

### Usage

Run the following command:
```
srun srun_simple.sh
```

Slurm array jobs make it easy to run many similar tasks. You just have to run the following command in the terminal:
```
sbatch --array=0-2:1 launch_job_arrays.sh
```
This command will submit and add the job to the Slurm queue. I have included the `--array` option but the procedure is the same for any other option.

In this particular example, the array option is already included inside the bash file, so we only need:
```
sbatch launch_job_arrays.sh
```

## Code examples
The examples are organized in folders:
* `CD22_23-P06_single_job` contains...
* `CD22_23-P07_job_arrays` contains...

## Useful terminal commands
Show information about your job(s) in the queue. When run without the `-u, --user=<user_list>` option, shows a list of your job(s) and all other jobs in the queue.
```
squeue -u <user_id>
```

Delete every output file (careful):
```
rm *.out
```

## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
[linkedin-url]: https://linkedin.com/in/sfandres
[slurm]: https://slurm.schedmd.com/documentation.html
[anaconda]: https://docs.anaconda.com/anaconda/install/linux/
