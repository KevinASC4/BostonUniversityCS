def is_palindrome(n):
    return str(n) == str(n)[::-1]

def largest_palindrome_product():
    max_palindrome = 0
    factors = (0, 0)
    for i in range(10, 100):         # 2-digit numbers
        for j in range(100, 1000):   # 3-digit numbers
            product = i * j
            if is_palindrome(product) and product > max_palindrome:
                max_palindrome = product
                factors = (i, j)
    return max_palindrome, factors

result, (a, b) = largest_palindrome_product()
print(f"Largest palindromic number is {result} = {a} × {b}")