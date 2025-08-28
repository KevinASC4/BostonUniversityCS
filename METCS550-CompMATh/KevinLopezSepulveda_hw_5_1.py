def monte_carlo_pi(n, N):
    pi_estimate = 4 * n / N
    error = abs(pi_estimate - 3.1415)
    return pi_estimate, error

N = 1000
n = 785
pi_val, err = monte_carlo_pi(n, N)
print(f"Estimated pi: {pi_val}, Error: {err}")
