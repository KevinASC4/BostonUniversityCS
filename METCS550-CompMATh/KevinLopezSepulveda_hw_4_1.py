import numpy as np
import matplotlib.pyplot as plt

# Create a unit circle (parametric)
theta = np.linspace(0, 2 * np.pi, 300)
circle = np.array([np.cos(theta), np.sin(theta)])  # shape (2, N)

# Define transformation matrices
M1 = np.array([[1.5, 0], [0, 1]])         # Expand x by 1.5
M2 = np.array([[1, 0], [0, 0.75]])        # Contract y by 0.75
M3 = np.array([[1, 2], [0, 1]])           # Shear x by 2
M4 = np.array([[1, 0], [1.25, 1]])        # Shear y by 1.25
M5 = np.array([[np.cos(np.pi/4), -np.sin(np.pi/4)],
               [np.sin(np.pi/4), np.cos(np.pi/4)]])  # Rotate CCW π/4
M6 = np.array([[np.cos(-np.pi/6), -np.sin(-np.pi/6)],
               [np.sin(-np.pi/6), np.cos(-np.pi/6)]])  # Rotate CW π/6

# Store transformations and titles
transformations = [M1, M2, M3, M4, M5, M6]
titles = [
    "M1: Expand x by 1.5",
    "M2: Contract y by 0.75",
    "M3: Shear x by 2",
    "M4: Shear y by 1.25",
    "M5: Rotate CCW π/4",
    "M6: Rotate CW π/6"
]

# Plotting
fig, axes = plt.subplots(2, 3, figsize=(15, 10))
for i, (M, title) in enumerate(zip(transformations, titles)):
    transformed_circle = M @ circle
    row, col = divmod(i, 3)
    ax = axes[row, col]
    ax.plot(circle[0], circle[1], 'k--', label='Original Circle')
    ax.plot(transformed_circle[0], transformed_circle[1], 'r', label='Transformed')
    ax.set_aspect('equal')
    ax.grid(True)
    ax.set_title(f"{title}\nArea: {abs(np.linalg.det(M)):.2f} × π")
    ax.legend()

plt.tight_layout()
plt.show()
