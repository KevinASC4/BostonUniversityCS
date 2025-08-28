import numpy as np

A = np.array([[1, 2], [3, 4]])
I = np.eye(2)

# Characteristic polynomial coefficients: λ² - 5λ - 2
# Calculate eigenvalues
eigvals, eigvecs = np.linalg.eig(A)

print("Eigenvalues:")
print(eigvals)

print("\nEigenvectors (columns):")
print(eigvecs)

# Compute P(A) = A^2 - 5A - 2I
P_A = A @ A - 5 * A - 2 * I
print("\nP(A) = A^2 - 5A - 2I:")
print(P_A)
