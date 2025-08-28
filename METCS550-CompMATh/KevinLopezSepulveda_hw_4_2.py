import numpy as np
import matplotlib.pyplot as plt
from numpy.linalg import eig, det

# Define the matrices again
M1 = np.array([[1.5, 0], [0, 1]])
M2 = np.array([[1, 0], [0, 0.75]])
M3 = np.array([[1, 2], [0, 1]])
M4 = np.array([[1, 0], [1.25, 1]])
M5 = np.array([[np.cos(np.pi/4), -np.sin(np.pi/4)],
               [np.sin(np.pi/4), np.cos(np.pi/4)]])
M6 = np.array([[np.cos(-np.pi/6), -np.sin(-np.pi/6)],
               [np.sin(-np.pi/6), np.cos(-np.pi/6)]])

matrices = [M1, M2, M3, M4, M5, M6]
titles = ["M1", "M2", "M3", "M4", "M5", "M6"]

fig, axes = plt.subplots(2, 3, figsize=(15, 10))
for i, (M, title) in enumerate(zip(matrices, titles)):
    λ, v = eig(M)
    row, col = divmod(i, 3)
    ax = axes[row, col]

    # Plot eigenvectors
    for j in range(len(λ)):
        vec = v[:, j].real
        ax.quiver(0, 0, vec[0], vec[1], angles='xy', scale_units='xy', scale=1, color='r')
        ax.text(vec[0]*1.1, vec[1]*1.1, f"λ={λ[j]:.2f}", fontsize=10, color='blue')

    ax.set_xlim(-2, 2)
    ax.set_ylim(-2, 2)
    ax.axhline(0, color='gray', lw=0.5)
    ax.axvline(0, color='gray', lw=0.5)
    ax.set_aspect('equal')
    ax.set_title(f"{title}\nCharacteristic Poly: det(M - λI) = 0")

plt.tight_layout()
plt.show()
