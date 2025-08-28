import numpy as np
import matplotlib.pyplot as plt

S = np.array([[0, 0, 1, 1],
              [0, 1, 1, 0]])

# Matrices from previous problems
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
# Compute matrix powers
M1_sq = np.linalg.matrix_power(M1, 2)
M3_cub = np.linalg.matrix_power(M3, 3)

# Compute inverses
M2_inv = np.linalg.inv(M2)
M4_inv = np.linalg.inv(M4)
M4_inv_sq = np.linalg.matrix_power(M4_inv, 2)

# Composite transformations
Comp1 = M1_sq @ M3_cub @ M5  # (M1^2)(M3^3)M5
Comp2 = M2_inv @ M4_inv_sq @ M6  # (M2^-1)(M4^-2)M6

# Apply transformations to the square S
S_comp1 = Comp1 @ S
S_comp2 = Comp2 @ S

# Extract transformed vertices for printing
vertices = ['A\'', 'B\'', 'C\'', 'D\'']

print("Transformation 1: (M1^2)(M3^3)M5 applied to square vertices:")
for i, vertex in enumerate(vertices):
    print(f"{vertex} = {S_comp1[:, i]}")

print("\nTransformation 2: (M2^-1)(M4^-2)M6 applied to square vertices:")
for i, vertex in enumerate(vertices):
    print(f"{vertex} = {S_comp2[:, i]}")

# Plotting results
def plot_polygon(ax, points, style, label):
    pts = np.column_stack([points, points[:, 0]])  # Close polygon
    ax.plot(pts[0], pts[1], style, label=label)
    ax.set_aspect('equal')
    ax.grid(True)
    ax.legend()



fig, axs = plt.subplots(1, 2, figsize=(12, 6))

# Original square
axs[0].plot(np.append(S[0], S[0,0]), np.append(S[1], S[1,0]), 'b-', label='Original Square')
plot_polygon(axs[0], S_comp1, 'r--', 'Transformed (Comp1)')
plot_polygon(axs[1], S_comp2, 'g--', 'Transformed (Comp2)')
axs[0].set_title('Transformation 1: (M1^2)(M3^3)M5')

axs[1].plot(np.append(S[0], S[0,0]), np.append(S[1], S[1,0]), 'b-', label='Original Square')
plot_polygon(axs[1], S_comp2, 'g--', 'Transformed (Comp2)')
axs[1].set_title('Transformation 2: (M2^-1)(M4^-2)M6')

plt.show()
