#
# Simulation Study
#

library(tidyverse)

source(glue::glue("{here::here()}/simulate.R"))
source(glue::glue("{here::here()}/wrapper.R"))
source(glue::glue("{here::here()}/env.R"))

cache_path <- Sys.getenv("SIMULATION_CACHE_PATH")
task_id <- Sys.getenv("SLURM_ARRAY_TASK_ID")

if(cache_path == "") stop("Please set SIMULATION_CACHE_PATH environment variable.")
if(task_id == "") stop("Task id not set. Please set SLURM_ARRAY_TASK_ID, or run simulations through a Slurm job array, which will set this environment variable for you.")

N_simulations <- 1
simulations <- expand_grid(
  index = as.numeric(task_id),
  N = c(100, 250, 500, 1000),
  alpha = c(0, 4, 8)
) 

simulations <- simulations %>%
  mutate(
    seed = index
  ) %>%
  mutate(
    data = pmap(list(seed, N, alpha), simulate_data),
    path = glue::glue("{cache_path}/{N}/{alpha}_{index}.rds"),
    fits = pmap(list(index, N, alpha, data, path), wrapper)
  )
