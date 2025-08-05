library(tidyverse)

root <- rprojroot::is_git_root                                                                         
basepath <- root$find_file("simulation_study_1")  

source(glue::glue("{basepath}/env.R"))

results_path <- Sys.getenv("SIMULATION_RESULTS_PATH")
if(results_path == "") stop("Please set SIMULATION_RESULTS_PATH environment variable.")

simulations <- read_rds(glue::glue("{results_path}/simulation_results.rds"))

table <- simulations |>
  group_by(N, alpha) |>
  mutate(covered = ci_lower < ate & ci_upper > ate, error = onestep - ate) |>
  summarize(
    coverage = mean(covered), 
    n = n(), 
    mae = mean(abs(error)), 
    me = mean(error)
  ) |>
  arrange(N)

table_formatted <- table |> 
  select(N, alpha, mae, me, coverage) |> 
  mutate_at(vars(c(mae, me)), scales::number_format(accuracy = 0.01)) |> 
  mutate_at(vars(coverage), scales::percent_format(accuracy = 0.1)) |> 
  ungroup()

print(table_formatted)
