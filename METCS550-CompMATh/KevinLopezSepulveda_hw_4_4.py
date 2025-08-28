import numpy as np
from numpy.linalg import det, norm

# Define matrices
A = np.array([[1, 4], [2, 3]])
B = np.array([[5, 19], [-2, 5]])
C = np.array([[2, 1, 9], [5, 7, 1], [4, 7, 1]])

# Determinants
det_A = round(det(A))
det_B = round(det(B))
det_C = round(det(C))

# L1 Norms (max column sum)
L1_A = norm(A, 1)
L1_B = norm(B, 1)
L1_C = norm(C, 1)

# Print results
print("Matrix A: det =", det_A, ", L1 norm =", L1_A)
print("Matrix B: det =", det_B, ", L1 norm =", L1_B)
print("Matrix C: det =", det_C, ", L1 norm =", L1_C)
