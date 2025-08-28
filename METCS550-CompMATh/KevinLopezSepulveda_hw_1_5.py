def find_pythagorean_triplet(sum_total):
    for a in range(1, sum_total):
        for b in range(a + 1, sum_total - a):
            c = sum_total - a - b
            if a * a + b * b == c * c:
                return a, b, c, a * b * c

# Problem asks for sum a + b + c = 1000
a, b, c, product = find_pythagorean_triplet(1000)
print(f"Pythagorean triplet: a={a}, b={b}, c={c}")
print(f"Product abc = {product}")
