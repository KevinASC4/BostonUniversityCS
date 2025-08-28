--------------------------------------------------------------------------------
#KEVIN LOPEZ SEPULVEDA
#HOMEWORK 1
#METCS555
--------------------------------------------------------------------------------
#Problem 1
--------------------------------------------------------------------------------
# 1.a.i: F(-3.5) for X ~ N(1.0, 2)
pnorm(-3.5, mean = 1.0, sd = 2)  
# → Returns P(X ≤ -3.5)

# 1.a.ii: F(0.5) for X ~ N(-5.0, 4)
pnorm(0.5, mean = -5.0, sd = 4)  
# → Returns P(X ≤ 0.5)

# 1.b.i: F(2.5) for chi-squared with df = 15
pchisq(2.5, df = 15)

# 1.b.ii: F(15) for chi-squared with df = 35
pchisq(15, df = 35)

# 1.c: CDF and tail probability relationship
# P(X > x) = 1 - P(X ≤ x)
1 - pnorm(1.5)  # tail probability

--------------------------------------------------------------------------------
#Problem 2
--------------------------------------------------------------------------------
# 2.(a to b): Binomial P(k)

# (a) n=5, p=1/3, k=2
dbinom(2, size=5, prob=1/3)

# (b) n=7, p=1/2, k=3
dbinom(3, size=7, prob=0.5)

# (c) n=4, p=1/4, k=2
dbinom(2, size=4, prob=0.25)

# 2.(g to h): Standard normal P(a ≤ Z ≤ b)

# (a)
pnorm(1.13) - pnorm(-0.81)

# (b)
pnorm(1.6) - pnorm(-0.23)

# (c)
pnorm(2.03) - pnorm(0.53)

# (d)
pnorm(1.50) - pnorm(0.15)

# 2.(w to x): Standard normal P(Z ≤ x), etc.

# (a)
pnorm(0.73)

# (b)
pnorm(1.8)

# (c)
1 - pnorm(0.2)

# (d)
1 - pnorm(-1.5)  # Or pnorm(1.5)

# (e) Exact value: P(Z = 1.8) = 0
0

# (f) P(|Z| ≤ 0.25)
pnorm(0.25) - pnorm(-0.25)

# 2.(w-x): X ~ N(μ=8, σ=4)

# (a) P(5 ≤ X ≤ 10)
pnorm(10, mean=8, sd=4) - pnorm(5, mean=8, sd=4)

# (b)
pnorm(15, mean=8, sd=4) - pnorm(10, mean=8, sd=4)

# (c)
pnorm(9, mean=8, sd=4) - pnorm(3, mean=8, sd=4)

# (d)
pnorm(7, mean=8, sd=4) - pnorm(3, mean=8, sd=4)

# (e) P(X ≥ 15)
1 - pnorm(15, mean=8, sd=4)

# (f) P(X ≤ 5)
pnorm(5, mean=8, sd=4)

# 2.ff to gg: Student weight problem X ~ N(155, 20), n = 2000

# (a) P(X ≤ 100)
pnorm(100, mean=155, sd=20) * 2000

# (b) P(120 ≤ X ≤ 130)
(pnorm(130, mean=155, sd=20) - pnorm(120, mean=155, sd=20)) * 2000

# (c) P(150 ≤ X ≤ 175)
(pnorm(175, mean=155, sd=20) - pnorm(150, mean=155, sd=20)) * 2000

# (d) P(X ≥ 200)
(1 - pnorm(200, mean=155, sd=20)) * 2000
--------------------------------------------------------------------------------
#Problem 3
--------------------------------------------------------------------------------

#Normal distribution over 4 IID is chisquared.  
1 - pchisq(35 / 4, df = 4)
--------------------------------------------------------------------------------
#Problem 4
--------------------------------------------------------------------------------
# a. Histogram of sample means
set.seed(42)
mu <- 5
sigma <- 2
n <- 30     # sample size
k <- 100000  # number of groups

samples <- replicate(k, mean(rnorm(n, mean = mu, sd = sigma)))
hist(samples, probability = TRUE, main = "Histogram of Sample Means", xlab = "Sample Mean")
lines(density(samples), col = "blue", lwd = 2)

# b. Mean convergence as n increases
set.seed(123)
k <- 1
n_values <- seq(10, 100000, by = 50)
means <- sapply(n_values, function(n) mean(rnorm(n, mean = mu, sd = sigma)))
plot(n_values, means, type = "l", col = "red", 
     main = "Convergence of Sample Mean", 
     xlab = "Sample Size", ylab = "Sample Mean")
abline(h = mu, col = "blue", lty = 2)
------------------------------------------------------------------------------
#Problem 5
------------------------------------------------------------------------------
# 5a: Generate a large population from a right-skewed distribution (exponential)
set.seed(123)
population <- rexp(100000, rate = 1)

# 5b: Plot the histogram and density of the population distribution
hist(population, breaks = 50, probability = TRUE,
     main = "Histogram of Population (Exponential Distribution)",
     xlab = "Value", col = "lightblue", border = "white")
lines(density(population), col = "darkblue", lwd = 2)

# 5c: Compute and report population mean and variance
pop_mean <- mean(population)
pop_var <- var(population)
cat("Population Mean:", pop_mean, "\n")
cat("Population Variance:", pop_var, "\n")

# 5d: Sampling for n = 5, 30, 100, 1000
sample_sizes <- c(5, 30, 100,1000)
num_samples <- 10000

# Store sample means
sample_means_list <- list()

for (n in sample_sizes) {
  sample_means <- replicate(num_samples, mean(sample(population, size = n, replace = TRUE)))
  sample_means_list[[as.character(n)]] <- sample_means
}
# 5e: Plot histograms 
par(mfrow = c(1, 4))  

for (n in sample_sizes) {
  sample_means <- sample_means_list[[as.character(n)]]
  xbar_centered <- (sample_means - pop_mean) / sqrt(pop_var / n)
  
  hist(xbar_centered, probability = TRUE, breaks = 40,
       main = paste("n =", n), col = "lightgreen",
       xlab = expression((bar(X) - mu)/(sigma/sqrt(n))))
  
  curve(dnorm(x), col = "red", lwd = 2, add = TRUE)
}

