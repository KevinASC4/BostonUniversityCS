from collections import defaultdict

sum_counts = {2:1, 3:2, 4:3, 5:4, 6:5, 7:6, 8:5, 9:4, 10:3, 11:2, 12:1}
total = 36
distribution = {}

for s, count in sum_counts.items():
    value = s if s % 2 == 1 else -s
    prob = count / total
    distribution[value] = distribution.get(value, 0) + prob

expected_value = sum(value * prob for value, prob in distribution.items())

print("Probability distribution:")
for value, prob in sorted(distribution.items()):
    print(f"Value: {value}, Probability: {prob:.4f}")
print(f"Expected value: {expected_value}")
