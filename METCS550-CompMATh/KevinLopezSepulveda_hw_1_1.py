import timeit

def find_euler_counterexample():
    solutions = []
    for a1 in range(20, 41):
        a1_5 = a1**5
        for a2 in range(80, 101):
            a2_5 = a2**5
            for a3 in range(100, 121):
                a3_5 = a3**5
                for a4 in range(120, 141):
                    a4_5 = a4**5
                    total = a1_5 + a2_5 + a3_5 + a4_5
                    # Try all b in the given range to see if b^5 equals the sum
                    for b in range(140, 161):
                        if total == b**5:
                            solutions.append((a1, a2, a3, a4, b))
    return solutions

# Measure execution time
execution_time = timeit.timeit('find_euler_counterexample()', globals=globals(), number=1)
print("Execution time:", execution_time, "seconds")

# Display the solution(s)
results = find_euler_counterexample()
for r in results:
    print(f"Found solution: {r[0]}^5 + {r[1]}^5 + {r[2]}^5 + {r[3]}^5 = {r[4]}^5")