import numpy as np
import matplotlib.pyplot as plt

def flip_coins(mu, n):
    """
    Simulate flipping each coin n times.
    mu: array-like of coin head probabilities (length K)
    n: number of flips per coin
    Returns: 2D numpy array (K x n) with 1 for heads and 0 for tails
    """
    mu = np.array(mu)
    K = len(mu)
    # Each row is coin i, columns are flips
    flips = np.random.binomial(1, mu[:, None], size=(K, n))
    return flips

def ae_core(alpha=0.05, mu=None):
    """
    Action Elimination algorithm to find the best coin.
    alpha: confidence level (default 0.05)
    mu: array of true coin probabilities; if None, generate randomly
    """
    if mu is None:
        K = 6
        # Generate random mu's ensuring exactly one best coin
        mu = np.random.uniform(0.1, 0.9, size=K)
        best_idx = np.argmax(mu)
        # Make sure one coin is strictly best
        mu[best_idx] = max(mu) + 0.05
        mu = np.clip(mu, 0, 1)
    else:
        K = len(mu)
    
    # Initialization
    surviving = np.arange(K)  # Indices of surviving arms
    round_num = 0
    rounds = []
    survivors_per_round = []

    # Number of samples per round (can increase or keep constant)
    # Here we double samples each round for tighter confidence
    n_samples = 1
    
    # Keep track of all samples and means
    total_samples = np.zeros(K, dtype=int)
    total_heads = np.zeros(K, dtype=int)

    while len(surviving) > 1:
        round_num += 1
        # Flip coins only for surviving arms
        flips = flip_coins(mu[surviving], n_samples)
        # Update total heads and samples
        total_heads[surviving] += flips.sum(axis=1)
        total_samples[surviving] += n_samples

        # Compute empirical means
        empirical_means = total_heads[surviving] / total_samples[surviving]

        # Compute confidence radius using Hoeffding's inequality
        delta = alpha / (round_num * K)  # Adjust delta to control error over rounds
        radius = np.sqrt(np.log(2 / delta) / (2 * total_samples[surviving]))

        # Confidence intervals
        lower_bounds = empirical_means - radius
        upper_bounds = empirical_means + radius

        # Find max lower bound (best confident lower estimate)
        max_lower = np.max(lower_bounds)

        # Eliminate arms whose upper bound is less than max lower bound
        survivors_mask = upper_bounds >= max_lower
        surviving = surviving[survivors_mask]

        # Record for plotting
        rounds.append(round_num)
        survivors_per_round.append(surviving.copy())

        # Double samples for next round (optional, you can choose other schemes)
        n_samples *= 2

    # Final surviving arm is best
    best_arm = surviving[0]

    # Plot surviving arms per round
    plt.figure(figsize=(10, 6))
    for r, surv in zip(rounds, survivors_per_round):
        plt.scatter([r]*len(surv), surv, color='blue')
    plt.xlabel('Round Number')
    plt.ylabel('Arm Index')
    plt.title('Action Elimination: Surviving Arms per Round')
    plt.grid(True)
    plt.show()

    print(f"Best arm found: {best_arm} with true mu = {mu[best_arm]:.4f}")
    return best_arm, mu

# Example run with default K=6
ae_core()

# To run with K=35, just generate mu accordingly:
# mu_35 = np.random.uniform(0.1, 0.9, size=35)
# mu_35[np.argmax(mu_35)] += 0.05  # ensure one strictly best arm
# ae_core(alpha=0.05, mu=mu_35)
