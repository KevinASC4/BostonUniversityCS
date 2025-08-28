import sympy as sp

# Define the symbolic variable
x = sp.Symbol('x')

# Optional: pretty print formatting
sp.init_printing()

# Define all functions from Problem 1
functions = [
    ('f(x) = 2', 2),
    ('f(x) = x + 1', x + 1),
    ('f(x) = 2x^2 + x', 2*x**2 + x),
    ('f(x) = x^3 + 3', x**3 + 3),
    ('f(x) = 2√x', 2 * sp.sqrt(x)),
    ('f(x) = e^(x+1)', sp.exp(x + 1)),
    ('f(x) = 3^x', 3**x),
    ('f(x) = log(x) + 1', sp.log(x) + 1),
    ('f(x) = sin(x + π/6)', sp.sin(x + sp.pi/6)),
    ('f(x) = cos(x + π/6)', sp.cos(x + sp.pi/6))
]

# Compute and print symbolic derivatives
print("Symbolic Derivatives using SymPy:\n")
for name, fx in functions:
    dfx = sp.diff(fx, x)
    print(f"{name}\n  → Derivative: {dfx}\n")
