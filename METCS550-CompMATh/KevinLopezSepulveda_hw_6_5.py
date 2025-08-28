import sympy as sp

# Define symbols
x, y, z = sp.symbols('x y z')

# Define symmetric matrix A
A = sp.Matrix([
    [2, 10, -2],
    [10, 5, 8],
    [-2, 8, 11]
])

# Compute eigenvalues
eigenvals = A.eigenvals()  # exact symbolic eigenvalues
eigenvals_numeric = A.eigenvals()  # for numeric approximation, see below

print("Exact eigenvalues (symbolic):")
for val, mult in eigenvals.items():
    print(f"Eigenvalue: {val}, multiplicity: {mult}")

# Numeric approximation
eigenvals_approx = [sp.N(ev) for ev in A.eigenvals()]
print("\nApproximate numeric eigenvalues:")
print(eigenvals_approx)

# Check if positive-definite
if all(ev > 0 for ev in eigenvals_approx):
    print("\nQuadratic form is positive-definite")
else:
    print("\nQuadratic form is NOT positive-definite")
