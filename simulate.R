#' Simulate data for simulation study
#'
#' @param seed random number seed
#' @param N number of observations
#' @param alpha strength of confounding
#'
#' @return data frame of simulated data. 
#' 
simulate_data <- function(seed = 1, N, alpha = 1) {
  set.seed(seed)
  
  X <- runif(N, -1, 1)
  A <- rbinom(N, 1, plogis(alpha * X))
  Y <- rbinom(N, 1, plogis(X + A))

  tibble(X, A, Y)
}

# Calculate true ATE under simulation DGP
calculate_ate <- function() {
  integrate(\(x) plogis(x + 1) * 1/2, -1, 1)$value - integrate(\(x) plogis(x) * 1/2, -1, 1)$value
}
