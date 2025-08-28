import numpy as np
import matplotlib.pyplot as plt

# Bisection method (3 iterations)
def bisection_iterations(f, a, b, iters=3):
    xs = []
    for _ in range(iters):
        mid = (a + b) / 2
        xs.append(mid)
        if f(a) * f(mid) < 0:
            b = mid
        else:
            a = mid
    return xs

# Plotting Bisection method
def plot_bisection(f, x_range, a, b, title):
    xs = bisection_iterations(f, a, b)
    colors = ['red', 'blue', 'green']  # colors for iteration points

    x_vals = np.linspace(x_range[0], x_range[1], 400)
    plt.figure(figsize=(6, 4))

    # Plot the function
    plt.plot(x_vals, f(x_vals), 'g', label='f(x)')
    plt.axhline(0, color='black', linewidth=0.7)

    # Scatter the iteration points
    for i, x in enumerate(xs):
        plt.scatter(x, f(x), color=colors[i], s=100, label=f'x{i+1}')

    plt.title(title)
    plt.legend()
    plt.grid(True)
    plt.show()

# Define all functions (same as before)
functions = [
    (lambda x: x**2 - 5, [-3, 3], "f(x) = x^2 - 5"),
    (lambda x: x**3 - 5, [-3, 3], "f(x) = x^3 - 5"),
    (lambda x: np.sqrt(x) - 1.5, [0.01, 3], "f(x) = sqrt(x) - 1.5"),
    (lambda x: np.exp(x) - 2, [-3, 3], "f(x) = e^x - 2"),
    (lambda x: 2**x - 0.5, [-3, 3], "f(x) = 2^x - 0.5"),
    (lambda x: np.log(x) - 1, [0.01, 3], "f(x) = log(x) - 1"),
    (lambda x: np.sin(x) - 0.5, [-3, 3], "f(x) = sin(x) - 0.5"),
    (lambda x: np.cos(x) - 0.5, [-3, 3], "f(x) = cos(x) - 0.5"),
]

# Run plots for each function
for f, x_range, title in functions:
    # Make sure domain is valid for a, b
    a, b = -3, 3
    if x_range[0] > a:  # adjust if domain starts > -3
        a = x_range[0]
    plot_bisection(f, x_range, a, b, title)
