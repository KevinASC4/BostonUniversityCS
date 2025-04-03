def maxsort(E):
    n = len(E)
    for i in range(n - 1, 0, -1):
        maxIndex = 0
        for j in range(1, i + 1):
            if E[j] > E[maxIndex]:
                maxIndex = j
        # Swap the maximum element with the last unsorted element
        E[maxIndex], E[i] = E[i], E[maxIndex]
    return E

# Test Cases
test_arrays = [
    [5, 2, 3, 4, 1],
    [1, 2, 3, 4, 5],
    [5, 1, 2, 3, 4],
    [3, 2, 1],
    [9, 7, 8, 5, 6, 4],
]

for arr in test_arrays:
    sorted_arr = maxsort(arr)
    print(f"Original: {arr} => Sorted: {sorted_arr}")

def int_to_roman(num):
    roman_numerals = [
        ('M', 1000),
        ('CM', 900),
        ('D', 500),
        ('CD', 400),
        ('C', 100),
        ('XC', 90),
        ('L', 50),
        ('XL', 40),
        ('X', 10),
        ('IX', 9),
        ('V', 5),
        ('IV', 4),
        ('I', 1),
    ]
    
    result = ""
    
    for symbol, value in roman_numerals:
        while num >= value:
            result += symbol
            num -= value
    
    return result

# Test cases for 2025, 3998, and 5999
numbers = [2025, 3998, 5999]
roman_representations = {num: int_to_roman(num) for num in numbers}

# Output the results
for num, roman in roman_representations.items():
    print(f"{num} in Roman numerals is: {roman}")