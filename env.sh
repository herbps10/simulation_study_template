#/bin/bash

# Path to main simulation study R script
export SIMULATION_STUDY_SCRIPT_PATH=""

# Path to cache folder for temporary results
export SIMULATION_CACHE_PATH=""

# Path to log folder
export SIMULATION_LOG_PATH=""

# Path to results folder for final results
export SIMULATION_RESULTS_PATH=""

# Slurm job configuration

export JOB_NAME="simstudy" 
export PARTITION=cpu_short # SLURM partition
export MAIL_USER=herbert.susmann@nyulangone.org
export CPUS_PER_TASK=1 # CPU to assign to each task in the array
export MEM_PER_CPU=10GB # Memory assigned per CPU
export TIME=12:00:00 # Job time limit
export ARRAY=1-10 # Array indexes to run
