import numpy as np
from scipy import integrate
import math

# Define the functions as Python functions (matching Problem 4)
functions = [
    ("f(x) = 2", lambda x: 2*np.ones_like(x)),
    ("f(x) = x + 1", lambda x: x + 1),
    ("f(x) = 2x² + x", lambda x: 2*x**2 + x),
    ("f(x) = x³ + 3", lambda x: x**3 + 3),
    ("f(x) = 2√x", lambda x: 2*np.sqrt(x)),
    ("f(x) = e^(x+1)", lambda x: np.exp(x + 1)),
    ("f(x) = 3^x", lambda x: 3**x),
    ("f(x) = ln(x) + 1", lambda x: np.log(x) + 1),
    ("f(x) = sin(x + π/6)", lambda x: np.sin(x + np.pi/6)),
    ("f(x) = cos(x + π/6)", lambda x: np.cos(x + np.pi/6)),
]

# Integration limits
a, b = 1, 5

# Points for trapz and Simpson 
x_vals = np.linspace(a, b, 1000)

print(f"Definite integrals over [{a}, {b}] with different methods:\n")

for name, f in functions:
    # Fixed quadrature (default order=5)
    fixed_quad_result, _ = integrate.fixed_quad(f, a, b)
    
    # Trapezoidal and Simpson require samples on x_vals
    y_vals = f(x_vals)
    
    trapz_result = np.trapz(y_vals, x_vals)
    simpson_result = integrate.simpson(y_vals, x_vals)
    
    print(f"{name}:")
    print(f"  Fixed quadrature: {fixed_quad_result:.6f}")
    print(f"  Trapezoidal     : {trapz_result:.6f}")
    print(f"  Simpson         : {simpson_result:.6f}\n")
