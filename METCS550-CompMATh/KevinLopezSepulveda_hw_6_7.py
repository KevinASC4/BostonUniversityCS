import sympy as sp

# Define symbols
x, y, lmbda = sp.symbols('x y lmbda')

# Define the function and constraint
f = x**2 + 2*y**2
g = x - 2*y + 1

# Lagrangian
L = f - lmbda * g

# Compute gradient
grad_L = [sp.diff(L, var) for var in (x, y, lmbda)]

# Solve the system grad_L = 0
solution = sp.solve(grad_L, (x, y, lmbda), dict=True)

# Extract minimum point and value
min_point = solution[0]
min_value = f.subs(min_point).evalf()

print("Solution (x, y, lambda):", min_point)
print("Minimum value of f(x, y):", min_value)
