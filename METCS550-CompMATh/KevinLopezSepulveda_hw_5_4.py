def uniform_prob(intervals):
    total_points = 100
    covered = set()
    for start, end in intervals:
        covered.update(range(start, end + 1))
    return len(covered) / total_points

print("P(X >= 25):", uniform_prob([(25, 99)]))
print("P(2.5 < X < 12.5):", uniform_prob([(3, 12)]))
print("P(8 < X <= 10 or 30 < X <= 32):", uniform_prob([(9, 10), (31, 32)]))
print("P(50 < X <= 70 or 60 < X <= 80):", uniform_prob([(51, 70), (61, 80)]))
