---------------------------------------------------------------------------------
#Problem 1
--------------------------------------------------------------------------------
# Given values
sigma <- 15
confidence_level <- 0.95
z <- qnorm(1 - (1 - confidence_level) / 2)

# Function to calculate sample size
required_sample_size <- function(sigma, margin_error, z) {
  n <- (z * sigma / margin_error)^2
  ceiling(n)
}

# Part 1: ±1.0 minute margin
n1 <- required_sample_size(sigma, 1.0, z)
cat("Required sample size for ±1.0 min:", n1, "\n")

# Part 2: ±1.25 minute margin
n2 <- required_sample_size(sigma, 1.25, z)
cat("Required sample size for ±1.25 min:", n2, "\n")
---------------------------------------------------------------------------------
#Problem 2
---------------------------------------------------------------------------------
# Set parameters
M <- 10000
n <- 50
mu <- 1
sigma <- 1
set.seed(123)

# a. Generate M samples of size n from Exp(1)
samples <- replicate(M, rexp(n, rate = 1))
print(samples)

# b. Compute vector of sample means
sample_means <- colMeans(samples)
print(sample_means)

# Plot histogram with theoretical normal overlay
hist(sample_means, breaks = 50, probability = TRUE, 
     main = "Sampling Distribution of Sample Means", xlab = "Sample Mean")
curve(dnorm(x, mean = mu, sd = sigma/sqrt(n)), col = "red", lwd = 2, add = TRUE)
legend("topright", legend = c("Sample Means", "N(1, 1/n)"), col = c("gray", "red"), lwd = 2)

# c. Compute confidence intervals at different levels
conf_levels <- c(0.90, 0.95, 0.99)
z_values <- qnorm(1 - (1 - conf_levels)/2)
CI_results <- data.frame(Level = conf_levels, z = z_values)
print(CI_results)

# For each level, compute lower and upper bounds
contains_mu <- list()
intervals <- list()

for (i in seq_along(z_values)) {
  z <- z_values[i]
  margin_error <- z * sigma / sqrt(n)
  lower <- sample_means - margin_error
  upper <- sample_means + margin_error
  contains <- (lower <= mu) & (upper >= mu)
  contains_mu[[i]] <- contains
  intervals[[i]] <- data.frame(lower = lower, upper = upper)
}

# d. Create summary table of empirical coverage
coverage_table <- data.frame(
  Confidence_Level = paste0(conf_levels * 100, "%"),
  Nominal = conf_levels,
  Empirical = sapply(contains_mu, function(x) mean(x))
)
print(coverage_table)

print("Empirical vs Nominal Coverage:")
print(coverage_table)

# e. Visualize 50 confidence intervals for each level
par(mfrow = c(1, 3), mar = c(4, 4, 3, 1))
for (i in seq_along(conf_levels)) {
  idx <- 1:50
  lower <- intervals[[i]]$lower[idx]
  upper <- intervals[[i]]$upper[idx]
  contains <- contains_mu[[i]][idx]
  plot(1:50, rep(mu, 50), type = "n", ylim = c(min(lower), max(upper)),
       xlab = "Sample Index", ylab = "Confidence Interval",
       main = paste0(conf_levels[i] * 100, "% CI"))
  abline(h = mu, col = "black", lty = 2)
  for (j in 1:50) {
    col <- ifelse(contains[j], "blue", "red")
    segments(j, lower[j], j, upper[j], col = col, lwd = 2)
  }
}
par(mfrow = c(1, 1))

--------------------------------------------------------------------------------
#Problem 3
-------------------------------------------------------------------------------
# Create a data frame summarizing the four motivating examples
hypothesis_examples <- data.frame(
  Example = c(
    "1. Average call hold time = 10 min",
    "2. Blue ad vs Red ad CTR",
    "3. Drug vs Placebo effectiveness",
    "4. Coin bias (fairness)"
  ),
  Null_Hypothesis = c(
    "H0: mu = 10",
    "H0: p1 = p2",
    "H0: mu_drug = mu_placebo",
    "H0: p = 0.5"
  ),
  Alternative_Hypothesis = c(
    "HA: mu != 10",
    "HA: p1 > p2",
    "HA: mu_drug > mu_placebo",
    "HA: p != 0.5"
  ),
  H0_Type = c("Simple", "Composite", "Composite", "Simple"),
  HA_Type = c("Composite", "Composite", "Composite", "Composite"),
  Group = c("H3", "H2", "H1", "H4")
)

# Print the summary table
print(hypothesis_examples, right=FALSE, row.names=FALSE)
------------------------------------------------------------------------------
#Problem 4
------------------------------------------------------------------------------
# Function to compute critical value and power for a Z-test
z_test_analysis <- function(mu0, mu1, sigma, n, alpha = 0.05, alternative = "greater") {
# Standard error
se <- sigma / sqrt(n)
    
# Critical z-value based on alpha
if (alternative == "greater") {
      z_crit <- qnorm(1 - alpha)
      x_crit <- mu0 + z_crit * se
      power <- 1 - pnorm((x_crit - mu1) / se)
    } else if (alternative == "less") {
      z_crit <- qnorm(alpha)
      x_crit <- mu0 + z_crit * se
      power <- pnorm((x_crit - mu1) / se)
    } else if (alternative == "two.sided") {
      z_crit <- qnorm(1 - alpha/2)
      x_upper <- mu0 + z_crit * se
      x_lower <- mu0 - z_crit * se
      power <- 1 - (pnorm((x_upper - mu1) / se) - pnorm((x_lower - mu1) / se))
    } else {
      stop("Invalid alternative hypothesis")
    }
    
    return(list(
      x_crit = round(x_crit, 3),
      power = round(power, 4),
      test = paste("Reject H0 if sample mean", 
                   ifelse(alternative == "greater", ">", 
                          ifelse(alternative == "less", "<", "is too far from")), 
                   round(x_crit, 3))
    ))
  }

# a. Cereal: H0: mu = 500 vs H1: mu = 505, sigma^2 = 225, so sigma = 15
# n unknown, so pick a reasonable n for illustration, say n = 30
result_a <- z_test_analysis(mu0 = 500, mu1 = 505, sigma = 15, n = 30, alpha = 0.05, alternative = "greater")

# b. Hemoglobin: H0: mu = 13 vs H1 = 14, sigma = 1.5, n = 145
result_b <- z_test_analysis(mu0 = 13, mu1 = 14, sigma = 1.5, n = 145, alpha = 0.05, alternative = "greater")

# c. Spending: H0: mu = 80 vs H1 = 85, sigma = 20, n = 49
result_c <- z_test_analysis(mu0 = 80, mu1 = 85, sigma = 20, n = 49, alpha = 0.05, alternative = "greater")

# Show results
cat("A. Cereal Weight Test:\n")
print(result_a)

cat("\nB. Hemoglobin Test:\n")
print(result_b)

cat("\nC. Website Spending Test:\n")
print(result_c)
-------------------------------------------------------------------------------
#Problem 5
------------------------------------------------------------------------------
simple_v_simple <- function(sigma, n, mu0, mu1, alpha = 0.05, X_bar) {
  # Compute standard error
  se <- sigma / sqrt(n)
  
  # Compute decision threshold under H0 (one-sided Z test)
  z_alpha <- qnorm(1 - alpha)
  threshold <- mu0 + z_alpha * se
  
  # Decision: reject or not
  decision <- ifelse(X_bar > threshold, "Reject H0", "Do Not Reject H0")
  
  # Compute power of the test
  z_beta <- (threshold - mu1) / se
  power <- 1 - pnorm(z_beta)
  
  # Return all components
  return(list(
    Decision = decision,
    Threshold = threshold,
    Power = power
  ))
}

# Example from 5a
result <- simple_v_simple(
  sigma = 4,      # standard deviation in ppb
  n = 16,         # sample size
  mu0 = 10,       # null hypothesis mean
  mu1 = 12,       # alternative hypothesis mean
  alpha = 0.05,   # significance level
  X_bar = 11.35   # observed sample mean
)

print(result)

------------------------------------------------------------------------------
#Problem 6
------------------------------------------------------------------------------
# Part (a): Resistor variance test

# Sample data
x_a <- c(100.2, 99.8, 100.5, 99.7, 100.1, 99.9, 100.3,
         99.6, 100.0, 100.4, 99.9, 100.2)

n_a <- length(x_a)
sigma0_a <- 0.40
sigma1_a <- 0.70

# Sample variance
s2_a <- var(x_a)

# Test statistic
T_a <- (n_a - 1) * s2_a / sigma0_a^2

# Critical value (chi-squared 95% quantile with n-1 df)
crit_a <- qchisq(0.95, df = n_a - 1)

# Decision
decision_a <- ifelse(T_a > crit_a, "Reject H0", "Do Not Reject H0")

# Power calculation (transform threshold for sigma1)
power_a <- 1 - pchisq(crit_a * (sigma0_a^2 / sigma1_a^2), df = n_a - 1)

cat("Part (a): Resistor variance test\n")
cat("Sample variance:", round(s2_a, 5), "\n")
cat("Test statistic T:", round(T_a, 4), "\n")
cat("Critical value:", round(crit_a, 4), "\n")
cat("Decision:", decision_a, "\n")
cat("Power of the test:", round(power_a, 4), "\n\n")



# Part (b): Volatility test

n_b <- 30
sigma0_b <- 0.01
sigma1_b <- 0.02
s2_b <- 1.8e-4

# Test statistic
T_b <- (n_b - 1) * s2_b / sigma0_b^2

# Critical value
crit_b <- qchisq(0.95, df = n_b - 1)

# Decision
decision_b <- ifelse(T_b > crit_b, "Reject H0", "Do Not Reject H0")

# Power calculation
power_b <- 1 - pchisq(crit_b * (sigma0_b^2 / sigma1_b^2), df = n_b - 1)

cat("Part (b): Volatility variance test\n")
cat("Test statistic T:", round(T_b, 4), "\n")
cat("Critical value:", round(crit_b, 4), "\n")
cat("Decision:", decision_b, "\n")
cat("Power of the test:", round(power_b, 4), "\n")


