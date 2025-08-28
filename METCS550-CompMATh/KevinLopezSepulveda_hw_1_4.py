import math

# Basic prime checker
def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(math.isqrt(n)) + 1):
        if n % i == 0:
            return False
    return True

# Generator for odd composite numbers
def odd_composites():
    n = 9  # Start from 9 since it's the smallest odd composite
    while True:
        if not is_prime(n) and n % 2 == 1:
            yield n
        n += 2

# Check Goldbach's conjecture form: n = p + 2*k^2
def satisfies_goldbach(n):
    for p in range(2, n):
        if is_prime(p):
            remainder = n - p
            if remainder % 2 == 0:
                k_squared = remainder // 2
                if math.isqrt(k_squared) ** 2 == k_squared:
                    return True
    return False

# Main loop
def find_smallest_counterexample():
    for n in odd_composites():
        if not satisfies_goldbach(n):
            return n

result = find_smallest_counterexample()
print(f"The smallest odd composite that cannot be written as sum of a prime and twice a square is: {result}")