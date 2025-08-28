import numpy as np
import pandas as pd
import sympy as sp
import matplotlib.pyplot as plt

# Setup symbolic math
x = sp.Symbol('x')
dx = 0.2
x_val = 1.0

# Define functions from Problem 1
function_data = [
    ("f(x) = 2",            lambda x: 2*np.ones_like(x),         2),
    ("f(x) = x + 1",        lambda x: x + 1,                     x + 1),
    ("f(x) = 2x² + x",      lambda x: 2*x**2 + x,                2*x**2 + x),
    ("f(x) = x³ + 3",       lambda x: x**3 + 3,                  x**3 + 3),
    ("f(x) = 2√x",          lambda x: 2*np.sqrt(x),              2*sp.sqrt(x)),
    ("f(x) = e^(x+1)",      lambda x: np.exp(x + 1),             sp.exp(x + 1)),
    ("f(x) = 3^x",          lambda x: 3**x,                      3**x),
    ("f(x) = ln(x) + 1",    lambda x: np.log(x) + 1,             sp.log(x) + 1),
    ("f(x) = sin(x + π/6)", lambda x: np.sin(x + np.pi/6),       sp.sin(x + sp.pi/6)),
    ("f(x) = cos(x + π/6)", lambda x: np.cos(x + np.pi/6),       sp.cos(x + sp.pi/6)),
]

# Derivative approximations
def forward(f): return (f(x_val + dx) - f(x_val)) / dx
def backward(f): return (f(x_val) - f(x_val - dx)) / dx
def central(f): return (f(x_val + dx) - f(x_val - dx)) / (2 * dx)

# Store results
results = []

for name, f_numpy, f_sym in function_data:
    try:
        fwd = round(forward(f_numpy), 4)
        bwd = round(backward(f_numpy), 4)
        cen = round(central(f_numpy), 4)
        exact = round(float(sp.diff(f_sym, x).evalf(subs={x: x_val})), 4)
    except Exception as e:
        fwd = bwd = cen = exact = None

    results.append({
        "Function": name,
        "Forward": fwd,
        "Backward": bwd,
        "Central": cen,
        "Exact": exact
    })

# Create DataFrame
df = pd.DataFrame(results)

# Highlighting function
def highlight_min_max(row):
    values = [row["Forward"], row["Backward"], row["Central"]]
    diffs = [abs(val - row["Exact"]) for val in values]
    min_idx = diffs.index(min(diffs))
    max_idx = diffs.index(max(diffs))
    colors = [''] * 5  # Function, Forward, Backward, Central, Exact
    colors[min_idx + 1] = 'color: green'
    colors[max_idx + 1] = 'color: red'
    return colors

# Display styled table
styled_df = df.style.apply(highlight_min_max, axis=1).format(precision=4)
styled_df  
df.to_csv("KevinLopez_hw_2_3_results.csv", index=False)
