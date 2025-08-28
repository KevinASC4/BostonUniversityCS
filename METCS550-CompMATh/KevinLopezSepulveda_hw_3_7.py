import math
from scipy.stats import norm

# Parameters
sigma = 15
confidence_level = 0.95
z = norm.ppf(1 - (1 - confidence_level) / 2)

# Function to calculate sample size
def required_sample_size(sigma, margin_error, z):
    n = (z * sigma / margin_error) ** 2
    return math.ceil(n)

# Part 1: Margin of error = 1.0
n1 = required_sample_size(sigma, 1.0, z)
print(f"Required sample size for ±1.0 min: {n1}")

# Part 2: Margin of error = 1.25
n2 = required_sample_size(sigma, 1.25, z)
print(f"Required sample size for ±1.25 min: {n2}")
