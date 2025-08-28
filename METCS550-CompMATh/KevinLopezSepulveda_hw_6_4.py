import sympy as sp

# Define symbol
x = sp.symbols('x')

# Define all functions symbolically
functions_sym = [
    x**2 - 5,                  # f(x) = x^2 - 5
    x**3 - 5,                  # f(x) = x^3 - 5
    sp.sqrt(x) - 1.5,           # f(x) = sqrt(x) - 1.5
    sp.exp(x) - 2,              # f(x) = e^x - 2
    2**x - 0.5,                 # f(x) = 2^x - 0.5
    sp.log(x) - 1,              # f(x) = log(x) - 1
    sp.sin(x) - 0.5,             # f(x) = sin(x) - 0.5
    sp.cos(x) - 0.5              # f(x) = cos(x) - 0.5
]

titles = [
    "x^2 - 5 = 0",
    "x^3 - 5 = 0",
    "sqrt(x) - 1.5 = 0",
    "e^x - 2 = 0",
    "2^x - 0.5 = 0",
    "log(x) - 1 = 0",
    "sin(x) - 0.5 = 0",
    "cos(x) - 0.5 = 0"
]

# Solve each equation exactly
for func, title in zip(functions_sym, titles):
    roots = sp.solve(sp.Eq(func, 0), x)
    print(f"{title}  -->  Roots: {roots}")
