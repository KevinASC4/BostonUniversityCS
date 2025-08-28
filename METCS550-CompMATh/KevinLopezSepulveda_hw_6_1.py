import numpy as np
import matplotlib.pyplot as plt

# Newton's method function
def newton_iteration(f, df, x0, iters=3):
    xs = [x0]
    for _ in range(iters):
        xs.append(xs[-1] - f(xs[-1]) / df(xs[-1]))
    return xs

# Plotting Newton's method steps
def plot_newton(f, df, x_range, x0, title):
    xs = newton_iteration(f, df, x0)
    colors = ['red', 'blue', 'green']  # tangent colors for iterations 1, 2, 3
    
    x_vals = np.linspace(x_range[0], x_range[1], 400)
    plt.figure(figsize=(6, 4))
    
    # Plot the function
    plt.plot(x_vals, f(x_vals), 'g', label='f(x)')
    plt.axhline(0, color='black', linewidth=0.7)
    
    # Plot tangents
    for i in range(3):
        xi = xs[i]
        yi = f(xi)
        slope = df(xi)
        tangent = lambda x: yi + slope * (x - xi)
        plt.plot(x_vals, tangent(x_vals), colors[i], label=f'Tangent {i+1}')
    
    plt.title(title)
    plt.legend()
    plt.grid(True)
    plt.show()

# Define all functions and derivatives
functions = [
    (lambda x: x**2 - 5, lambda x: 2*x, [-3, 3], "f(x) = x^2 - 5"),
    (lambda x: x**3 - 5, lambda x: 3*x**2, [-3, 3], "f(x) = x^3 - 5"),
    (lambda x: np.sqrt(x) - 1.5, lambda x: 1/(2*np.sqrt(x)), [0.01, 3], "f(x) = sqrt(x) - 1.5"),
    (lambda x: np.exp(x) - 2, lambda x: np.exp(x), [-3, 3], "f(x) = e^x - 2"),
    (lambda x: 2**x - 0.5, lambda x: np.log(2)*2**x, [-3, 3], "f(x) = 2^x - 0.5"),
    (lambda x: np.log(x) - 1, lambda x: 1/x, [0.01, 3], "f(x) = log(x) - 1"),
    (lambda x: np.sin(x) - 0.5, lambda x: np.cos(x), [-3, 3], "f(x) = sin(x) - 0.5"),
    (lambda x: np.cos(x) - 0.5, lambda x: -np.sin(x), [-3, 3], "f(x) = cos(x) - 0.5"),
]

# Generate plots for each function
for f, df, x_range, title in functions:
    plot_newton(f, df, x_range, 3, title)
