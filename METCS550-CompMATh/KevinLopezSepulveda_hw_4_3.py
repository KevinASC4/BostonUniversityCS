import numpy as np
import matplotlib.pyplot as plt

# Define matrices
M1 = np.array([[1.5, 0], [0, 1]])
M2 = np.array([[1, 0], [0, 0.75]])
M3 = np.array([[1, 2], [0, 1]])
M4 = np.array([[1, 0], [1.25, 1]])

theta = np.pi / 4
M5 = np.array([[np.cos(theta), -np.sin(theta)],
               [np.sin(theta),  np.cos(theta)]])

theta = -np.pi / 6
M6 = np.array([[np.cos(theta), -np.sin(theta)],
               [np.sin(theta),  np.cos(theta)]])

# Create unit circle
angles = np.linspace(0, 2*np.pi, 300)
circle = np.array([np.cos(angles), np.sin(angles)])  # shape (2, N)

# ---- a) (M1^2)(M3^3)M5
M1_squared = np.linalg.matrix_power(M1, 2)
M3_cubed   = np.linalg.matrix_power(M3, 3)
M_a = M1_squared @ M3_cubed @ M5
transformed_a = M_a @ circle
area_a = abs(np.linalg.det(M_a)) * np.pi

# ---- b) (M2^-1)(M4^-2)M6
M2_inv = np.linalg.inv(M2)
M4_inv_squared = np.linalg.matrix_power(np.linalg.inv(M4), 2)
M_b = M2_inv @ M4_inv_squared @ M6
transformed_b = M_b @ circle
area_b = abs(np.linalg.det(M_b)) * np.pi

# ---- Plotting
fig, axs = plt.subplots(1, 2, figsize=(14, 6))

# a) Plot
axs[0].plot(circle[0], circle[1], 'k--', label="Original Circle")
axs[0].plot(transformed_a[0], transformed_a[1], 'r', label="Transformed A")
axs[0].set_title(f"a) (M1²)(M3³)M5\nArea = {area_a:.2f}")
axs[0].set_aspect('equal')
axs[0].grid(True)
axs[0].legend()

# b) Plot
axs[1].plot(circle[0], circle[1], 'k--', label="Original Circle")
axs[1].plot(transformed_b[0], transformed_b[1], 'b', label="Transformed B")
axs[1].set_title(f"b) (M2⁻¹)(M4⁻²)M6\nArea = {area_b:.2f}")
axs[1].set_aspect('equal')
axs[1].grid(True)
axs[1].legend()

plt.tight_layout()
plt.show()
