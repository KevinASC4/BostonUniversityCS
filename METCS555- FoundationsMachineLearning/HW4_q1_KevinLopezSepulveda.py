import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from math import comb

# Set random seed for reproducibility
np.random.seed(42)

# a. Load data and calculate observed difference
data = pd.read_csv('alpaca_wool_quality.csv')

# Separate groups
treatment = data.loc[data['group'] == 'new', 'wool-quality']
control = data.loc[data['group'] == 'control', 'wool-quality']

# Sample sizes
m = len(treatment)
n = len(control)

# Sample means
mean_treatment = treatment.mean()
mean_control = control.mean()

# Observed test statistic
T_obs = mean_treatment - mean_control

print(f"Sample mean (treatment): {mean_treatment:.3f}")
print(f"Sample mean (control): {mean_control:.3f}")
print(f"Observed difference T_obs: {T_obs:.3f}")

# b. Boxplots
plt.boxplot([treatment, control], labels=['Treatment (new)', 'Control'])
plt.ylabel('Wool Quality Index')
plt.title('Boxplots of Wool Quality by Group')
plt.show()

# c. Permutation test
combined = np.concatenate([treatment.values, control.values])

B = 200
T_perm = np.zeros(B)

for i in range(B):
    np.random.shuffle(combined)
    pseudo_treatment = combined[:m]
    pseudo_control = combined[m:]
    T_perm[i] = pseudo_treatment.mean() - pseudo_control.mean()

# Maximum number of ways to split into groups of size m and n
max_splits = comb(m + n, m)
print(f"Maximum number of ways to split samples: {max_splits}")

# d. Histogram with observed difference
plt.hist(T_perm, bins=20, alpha=0.7, color='skyblue', edgecolor='black')
plt.axvline(T_obs, color='red', linestyle='dashed', linewidth=2, label='Observed Difference')
plt.xlabel('Difference in Sample Means')
plt.ylabel('Frequency')
plt.title('Permutation Distribution of Differences in Means')
plt.legend()
plt.show()

# e. Calculate p-value (two-sided test)
p_value = np.mean(np.abs(T_perm) >= np.abs(T_obs))
print(f"P-value: {p_value:.4f}")

if p_value < 0.05:
    print("Reject the null hypothesis: There is evidence the new shampoo changes wool quality.")
else:
    print("Fail to reject the null hypothesis: No significant evidence the new shampoo changes wool quality.")
