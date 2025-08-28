from scipy.stats import norm
import math

k = 100
p = 0.5
mean = k / p
variance = k * (1 - p) / (p ** 2)
std_dev = math.sqrt(variance)

z = (225 - mean) / std_dev
prob = 1 - norm.cdf(z)
print(f"Approximate P(X >= 225): {prob:.4f}")
