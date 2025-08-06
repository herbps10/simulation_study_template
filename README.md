# Cluster Simulation Study Template
This repository contains a simple template for a simulation study that can be run on a SLURM parallel computing cluster.

The simulation study in the template works in several steps:
1. *Launch* An array of jobs are submitted to the cluster using the `./sim start` command.
2. *`simstudy.R`*: When a job starts, it begins by executing the `simstudy.R` script. The script then does the following:
  a. Retrieves its array index from the `SLURM_ARRAY_TASK_ID` environment variable.
  b. Generates a set of simulation datasets using the array index to compute a unique seed, ensuring that the simulated datasets are unique to each job.
  c. For each simulated dataset, it calls the function `wrapper` specified in the `wrapper.R` file.
3. *`wrapper.R`*: the function `wrapper.R` contains the code that runs the statistical analysis for each simulated dataset.
  a. The `wrapper` function first checks to see if a cache file exists for the simulated dataset. If it does, then the cached result is returned.
  b. If no cache file exists, then the function runs the statistical analysis. This might involve computing point estimates and uncertainty intervals.
  c. The results of the analysis are saved in a cache file.
4. *`collect_results.R`*: after all jobs finish, running the `collect_results.R` file gathers all of the cached simulation results into one main results file.
5. *`analyze.R`*: running this file loads the main results file and generates summarized results, such as tables including mean error and empirical coverage.

## Configuration
Configuration is done by setting environment variables in the `env.sh` file.


## `sim` command 
The `sim` shell script gathers several common tasks into one place. 
```
Usage: ./sim <command>

Available commands:
  start     Start batch job
  cancel    Cancel running batch job
  reset     Clear logs
  clean     Clear cache
  status    Print current job status
  watch     Watch current job status
  logs      Print all logs
  cache     List existing cache files
  setup     Create cache and log directories
  help      Show this help message
```

## Git Subtree
A convenient way to copy this template into another repository is via `git subtree`.

Setup:
```
git remote add template git@github.com:herbps10/simulation_study_template.git
git fetch template
```

Add subdirectory:
```
git subtree add --prefix=simulation_study_1 template main --squash
```

Pulling updates:
```
git fetch template
git subtree pull --prefix=simulation_study_1 template main --squash
```

Pushing updates:
```
git subtree push --prefix=template template main
```
