import numpy as np

# Matrices from Problem 1
M1 = np.array([[1.5, 0],
               [0, 1]])

M2 = np.array([[1, 0],
               [0, 0.75]])

M3 = np.array([[1, 2],
               [0, 1]])

M4 = np.array([[1, 0],
               [1.25, 1]])

theta_5 = np.pi / 4
M5 = np.array([[np.cos(theta_5), -np.sin(theta_5)],
               [np.sin(theta_5),  np.cos(theta_5)]])

theta_6 = -np.pi / 6
M6 = np.array([[np.cos(theta_6), -np.sin(theta_6)],
               [np.sin(theta_6),  np.cos(theta_6)]])

matrices = [M1, M2, M3, M4, M5, M6]

def inverse_2x2(M):
    a, b = M[0,0], M[0,1]
    c, d = M[1,0], M[1,1]
    det = a*d - b*c
    if abs(det) < 1e-12:
        raise ValueError("Matrix is singular, no inverse.")
    inv = (1/det) * np.array([[d, -b],
                              [-c, a]])
    return inv

# Compute and print inverses
for i, M in enumerate(matrices, start=1):
    inv = inverse_2x2(M)
    print(f"M{i} inverse:\n{inv}\n")
