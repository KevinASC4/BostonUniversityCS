import numpy as np
import matplotlib.pyplot as plt

# Unit square vertices as columns: A, B, C, D
S = np.array([[0, 0, 1, 1],
              [0, 1, 1, 0]])

def plot_square(ax, vertices, color, label):
    x = np.append(vertices[0, :], vertices[0, 0])
    y = np.append(vertices[1, :], vertices[1, 0])
    ax.plot(x, y, color=color, label=label)
    ax.set_aspect('equal')
    ax.legend()
    ax.grid(True)

# 1. Expand x by factor 1.5
def expand_x(factor):
    M = np.array([[factor, 0],
                  [0, 1]])
    return M

# 2. Contract y by factor 0.75
def contract_y(factor):
    M = np.array([[1, 0],
                  [0, factor]])
    return M

# 3. Shear along x by factor 2 (x' = x + 2y)
def shear_x(factor):
    M = np.array([[1, factor],
                  [0, 1]])
    return M

# 4. Shear along y by factor 1.25 (y' = y + 1.25x)
def shear_y(factor):
    M = np.array([[1, 0],
                  [factor, 1]])
    return M

# 5. Counterclockwise rotation by angle theta
def rotate_ccw(theta):
    M = np.array([[np.cos(theta), -np.sin(theta)],
                  [np.sin(theta),  np.cos(theta)]])
    return M

# 6. Clockwise rotation by angle theta
def rotate_cw(theta):
    # clockwise rotation is counterclockwise by negative angle
    return rotate_ccw(-theta)

# Build the matrices
M1 = expand_x(1.5)
M2 = contract_y(0.75)
M3 = shear_x(2)
M4 = shear_y(1.25)
M5 = rotate_ccw(np.pi / 4)
M6 = rotate_cw(np.pi / 6)

matrices = [M1, M2, M3, M4, M5, M6]
titles = [
    'M1: Expand x by 1.5',
    'M2: Contract y by 0.75',
    'M3: Shear x by 2',
    'M4: Shear y by 1.25',
    'M5: Rotate CCW π/4',
    'M6: Rotate CW π/6'
]

# Plot all results
fig, axs = plt.subplots(2, 3, figsize=(15, 10))

for i, ax in enumerate(axs.flatten()):
    M = matrices[i]
    S_transformed = M @ S
    plot_square(ax, S, 'blue', 'Original')
    plot_square(ax, S_transformed, 'red', 'Transformed')
    ax.set_title(titles[i])

plt.tight_layout()
plt.show()
