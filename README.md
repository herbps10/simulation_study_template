# Simulation Study Template
This repository contains a simple template for a simulation study that can be run on a SLURM parallel computing cluster.

- `simstudy.R`: generates the simulation datasets and runs the statistical analysis on each one.
- `wrapper.R`: implements the statistical analysis for each dataset.
- `collect.R`: gathers the cached results from all the workers and combines them into one main results file.
- `analyze.R`: loads the main results file, summarizes the results, and generates any tables and figures.

Configuration is done by setting environment variables in the `env.sh` file.

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
