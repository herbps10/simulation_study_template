#
# The wrapper function runs the statistical analysis for each simulated dataset.
# 
wrapper <- function(index, N, alpha, data, path) {
  # Check cache
  if(!file.exists(dirname(path))) dir.create(dirname(path), recursive = TRUE)
  if(file.exists(path)) {
    return(read_rds(path))
  }

  # Run statistical analysis
  propensity_score_model <- glm(A ~ X, data = data, family = binomial(link = "logit"))
  outcome_model <- glm(Y ~ A + X, data = data, family = binomial(link = "logit"))

  pi_hat  <- predict(propensity_score_model, type = "response")
  mu0_hat <- predict(outcome_model, newdata = mutate(data, A = 0), type = "response")
  mu1_hat <- predict(outcome_model, newdata = mutate(data, A = 1), type = "response")
  mu_hat  <- ifelse(data$A == 1, mu1_hat, mu0_hat)

  eif <- mu1_hat - mu0_hat + ((data$A) / pi_hat - (1 - data$A) / (1 - pi_hat)) * (data$Y - mu_hat)

  onestep <- mean(eif)
  se <- sd(eif) / sqrt(nrow(data))
  ci <- onestep + qnorm(c(0.025, 0.975)) * se

  # Calculate true ATE
  ate <- calculate_ate()

  res <- tibble(
    index = index,
    N = N,
    alpha = alpha,
    onestep = onestep,
    se = se,
    ci_lower = ci[1],
    ci_upper = ci[2],
    ate = ate
  )

  write_rds(res, path, compress = "gz")

  return(res)
}
