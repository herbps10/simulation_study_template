# Cluster Simulation Study Template
This repository provides a flexible template for running simulation studies on a SLURM-based parallel computing cluster.

The workflow proceeds in several stages:

## Launch Jobs
You start the simulation study by running:
```
./sim start
```
This command submits an array job to SLURM, where each task in the array corresponds to a different run of the simulation. 

## 2. Simulation Script: `simstudy.R`

Each SLURM tasks begins by running `simstudy.R`. This script:
- Reads the job array index from the environment variable `SLURM_ARRAY_TASK_ID`.
- Uses the job array index to calculate a unique random seed, ensuring that each task simulates a different dataset.
- Simulates one or more datasets and, for each dataset, calls the `wrapper` function defined in `wrapper.R` to run the statistical analyses.

## 3. Analysis Function: `wrapper.R`

The `wrapper` function defines how each dataset is analyzed. It performs the following steps:

- *Cache Check*: before running the analysis, it checks whether a cached result file already exists for the current simulated datsaet. If it does, the function exits.
- *Run Analysis*: If no cached result is found, the function runs the statistical analysis (e.g. computing point estimates, uncertainty intervals, etc.).
- *Save Result*: The results are saved to the cache for later use. 

## 4. Result Collection: `collect_results.R`
After all array jobs complete, run:
```
Rscript collect_results.R
```
This script aggregates the cached results from all tasks into a single combined results file.

## 5. Summary Analysis: `analyze.R`
Finally, run:
```
Rscript analyze.R
```
This script loads the combined results and computes summary metrics (e.g., average error, empirical coverage). Customize this script to produce tables or plots for reporting.

## Configuration
All configuration for your simulation study is handled through environment variables defined in the `env.sh` file. This script is sourced by the job submission process and sets paths, job parameters, and SLURM options.

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
