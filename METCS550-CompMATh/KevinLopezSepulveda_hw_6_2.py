import numpy as np
import matplotlib.pyplot as plt

# Secant method iterations
def secant_iteration(f, x0, x1, iters=3):
    xs = [x0, x1]
    for _ in range(iters):
        f0, f1 = f(xs[-2]), f(xs[-1])
        x_next = xs[-1] - f1 * (xs[-1] - xs[-2]) / (f1 - f0)
        xs.append(x_next)
    return xs

# Plotting Secant method steps
def plot_secant(f, x_range, x0, x1, title):
    xs = secant_iteration(f, x0, x1)
    colors = ['red', 'blue', 'green']  # secant line colors

    x_vals = np.linspace(x_range[0], x_range[1], 400)
    plt.figure(figsize=(6, 4))

    # Plot function
    plt.plot(x_vals, f(x_vals), 'g', label='f(x)')
    plt.axhline(0, color='black', linewidth=0.7)

    # Plot secant lines for first 3 iterations
    for i in range(3):
        x_a, x_b = xs[i], xs[i+1]
        y_a, y_b = f(x_a), f(x_b)
        slope = (y_b - y_a) / (x_b - x_a)
        secant_line = lambda x: y_a + slope * (x - x_a)
        plt.plot(x_vals, secant_line(x_vals), colors[i], label=f'Secant {i+1}')

    plt.title(title)
    plt.legend()
    plt.grid(True)
    plt.show()

# Define all functions (same as before, but no derivatives needed)
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
    plot_secant(f, x_range, 3, 2.5, title)
