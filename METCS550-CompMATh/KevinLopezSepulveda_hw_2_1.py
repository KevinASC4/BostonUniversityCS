import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Define the domain equal to (-4,4)
x = np.linspace(-4, 4, 1000)
x_positive = x[x > 0]  # For special functions like sqrt(x) and log(x)

# Define functions and derivatives
functions = [
    (lambda x: 2*np.ones_like(x), lambda x: np.zeros_like(x), "f(x) = 2"),
    (lambda x: x + 1, lambda x: np.ones_like(x), "f(x) = x + 1"),
    (lambda x: 2*x**2 + x, lambda x: 4*x + 1, "f(x) = 2x² + x"),
    (lambda x: x**3 + 3, lambda x: 3*x**2, "f(x) = x³ + 3"),
    (lambda x: 2*np.sqrt(x), lambda x: 1/np.sqrt(x), "f(x) = 2√x", x_positive),
    (lambda x: np.exp(x + 1), lambda x: np.exp(x), "f(x) = e^(x+1)"),
    (lambda x: 3**x, lambda x: np.log(3)*3**x, "f(x) = 3^x"),
    (lambda x: np.log(x) + 1, lambda x: 1/x, "f(x) = ln(x) + 1", x_positive),
    (lambda x: np.sin(x + np.pi/6), lambda x: np.cos(x), "f(x) = sin(x + π/6)"),
    (lambda x: np.cos(x + np.pi/6), lambda x: -np.sin(x), "f(x) = cos(x + π/6)"),
]

# Create subplots
fig, axs = plt.subplots(5, 2, figsize=(14, 20))
axs = axs.ravel()  # Flatten 2D grid to 1D list

for i, func_data in enumerate(functions):
    if len(func_data) == 4:
        f, f_prime, title, x_vals = func_data
    else:
        f, f_prime, title = func_data
        x_vals = x

    ax = axs[i]
    ax.plot(x_vals, f(x_vals), 'g-', label='f(x)')
    ax.plot(x_vals, f_prime(x_vals), 'r--', label="f'(x)")

    # Point at x = 1
    if 1 in x_vals:
        ax.plot(1, f(1), 'ko', label='f(1)')
        ax.plot(1, f_prime(1), 'ks', label="f'(1)")

    ax.set_title(title)
    ax.axhline(0, color='gray', lw=0.5)
    ax.axvline(0, color='gray', lw=0.5)
    ax.legend(loc='best')
    ax.grid(True)

plt.tight_layout()
plt.show()

dx = 0.01
x = 1

def forward(f): return (f(x + dx) - f(x)) / dx
def backward(f): return (f(x) - f(x - dx)) / dx
def central(f): return (f(x + dx) - f(x - dx)) / (2 * dx)

# Define the functions
functions = [
    ("f(x) = 1", lambda x: 1, lambda x: 0),
    ("f(x) = x", lambda x: x, lambda x: 1),
    ("f(x) = x squared", lambda x: x**2, lambda x: 2*x),
    ("f(x) = x to the third", lambda x: x**3, lambda x: 1),
    ("f(x) = x to the fourth", lambda x: x**4, lambda x: 2*x),
    ("f(x) = cos(x)", np.cos, lambda x: -np.sin(x)),
]

# Build the table
rows = []
for name, f, f_prime in functions:
    row = {
        'Function': name,
        'Forward': round(forward(f), 5),
        'Backward': round(backward(f), 5),
        'Central': round(central(f), 5),
        'Exact': round(f_prime(1), 5)
    }
    rows.append(row)

# Create DataFrame
df = pd.DataFrame(rows)
print(df)