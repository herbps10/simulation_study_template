#/bin/bash

# === Simulation Paths ===

# Path to the main R script that runs the simulation
export SIMULATION_STUDY_SCRIPT_PATH="/path/to/script"

# Directory to cache intermediate results (e.g., per-task output)
export SIMULATION_CACHE_PATH="/path/to/cache"

# Directory to store SLURM log files (stdout and stderr for each job)
export SIMULATION_LOG_PATH="/path/to/logs"

# Directory for final processed results (e.g., combined output)
export SIMULATION_RESULTS_PATH="/path/to/results"

# === SLURM job configuration ===

# Name of the SLURM job (appears in job monitoring commands)
export JOB_NAME="simulation"

# SLURM partition to submit the job to (e.g., 'cpu', 'gpu')
export PARTITION=cpu

# Email address for job notifications (optional)
export MAIL_USER=email@test.com

# Number of CPUs to allocate per task
export CPUS_PER_TASK=1

# Memory per CPU (e.g., 2GB, 4000M)
export MEM_PER_CPU=2GB

# Time limit for each array task (format: HH:MM:SS)
export TIME=12:00:00

# SLURM array indices (e.g., 1-100 to run 100 parallel tasks)
export ARRAY=1-100
