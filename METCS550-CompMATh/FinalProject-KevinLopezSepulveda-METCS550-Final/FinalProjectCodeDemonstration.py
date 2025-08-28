import nashpy as nash
import numpy as np
import matplotlib.pyplot as plt

# Define the payoff matrices
# Example: Prisoner's Dilemma
# Player A payoff matrix
A = np.array([[ -1, -3],
              [  0, -2]])

# Player B payoff matrix
B = np.array([[ -1,  0],
              [ -3, -2]])

# Build the game
game = nash.Game(A, B)

print("Payoff matrices:")
print("Player A:\n", A)
print("Player B:\n", B)

# Compute Nash Equilibria
print("\nNash equilibria (support enumeration):")
equilibria = list(game.support_enumeration())
for eq in equilibria:
    sigma_A, sigma_B = eq
    print(f"Player A strategy: {sigma_A}, Player B strategy: {sigma_B}")
    print("Expected payoffs:", game[sigma_A, sigma_B])

# Monte Carlo Simulation to Estimate π

# Step 1: Set number of points (N)
N = 10000  # you can change this to a larger number for better accuracy

# Step 2: Generate random points inside the square [-1, 1] x [-1, 1]
x = np.random.uniform(-1, 1, N)
y = np.random.uniform(-1, 1, N)

# Step 3: Count how many fall inside the unit circle (x^2 + y^2 <= 1)
inside_circle = x**2 + y**2 <= 1
n = np.sum(inside_circle)

# Step 4: Estimate π
pi_estimate = (n / N) * 4

print(f"Total points (N): {N}")
print(f"Points inside circle (n): {n}")
print(f"Estimated π: {pi_estimate:.5f}")

# Step 5: Visualization
plt.figure(figsize=(6,6))
plt.scatter(x[inside_circle], y[inside_circle], color="blue", s=1, label="Inside Circle")
plt.scatter(x[~inside_circle], y[~inside_circle], color="red", s=1, label="Outside Circle")
circle = plt.Circle((0, 0), 1, color="green", fill=False, linewidth=2, label="Unit Circle")
plt.gca().add_patch(circle)
plt.gca().set_aspect("equal")
plt.title("Monte Carlo Simulation for π")
plt.xlabel("x")
plt.ylabel("y")
plt.legend()
plt.show()
