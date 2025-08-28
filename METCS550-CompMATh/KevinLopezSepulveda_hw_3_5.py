import numpy as np

def matrix_log_approx(M):
    I = np.eye(M.shape[0])
    X = M - I
    X2 = X @ X
    X3 = X2 @ X
    log_M = X - (1/2)*X2 + (1/3)*X3
    return log_M

# Matrix A
A = np.array([[1, 2],
              [0, 1]], dtype=float)

# Matrix A
B = np.array([[5, 9],
              [2, 5]], dtype=float)

# Compute inverse of A
A_inv = np.linalg.inv(A)
B_inv = np.linalg.inv(B)

print("log(A) approximation:")
print(matrix_log_approx(A))
print("\nlog(A^-1) approximation:")
print(matrix_log_approx(A_inv))

print("log(B) approximation:")
print(matrix_log_approx(B))
print("\nlog(B^-1) approximation:")
print(matrix_log_approx(B_inv))

# You can replace B once you provide the full matrix.
