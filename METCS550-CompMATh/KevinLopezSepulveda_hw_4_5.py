import numpy as np

A = np.array([
    [-3, 4, 0],
    [-2, 7, 6],
    [5, -8, 0]
])

det_A = np.linalg.det(A)
print(f"Determinant of A: {det_A:.0f}")
