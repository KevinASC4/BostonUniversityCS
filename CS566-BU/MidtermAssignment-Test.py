#Homework Problem 1
def combinations(n, k):
    # Base cases
    if n == k or k == 0:
        return 1
    # Recursive case
    return combinations(n - 1, k - 1) + combinations(n - 1, k)

test_values = [6, 10, 16]
for n in test_values:
    k = n // 2
    result = combinations(n, k)
    print(f"C1({n}, {k}) = {result}")

def combinations_memo(n, k, memo={}):
    # Base cases
    if n == k or k == 0:
        return 1
    # Check if result is already computed
    if (n, k) in memo:
        return memo[(n, k)]
    # Recursive case with memoization
    memo[(n, k)] = combinations_memo(n - 1, k - 1, memo) + combinations_memo(n - 1, k, memo)
    return memo[(n, k)]

# Testing the memoized function
for n in test_values:
    k = n // 2
    result = combinations_memo(n, k)
    print(f"C2({n}, {k}) = {result}")
#Homework Problem 2
class MaxHeap:
    def __init__(self, elements):
        self.heap = elements
        self.build_max_heap()

    def build_max_heap(self):
        for i in range(len(self.heap) // 2 - 1, -1, -1):
            self.heapify(i)

    def heapify(self, i):
        largest = i
        left = 2 * i + 1
        right = 2 * i + 2

        if left < len(self.heap) and self.heap[left] > self.heap[largest]:
            largest = left
        if right < len(self.heap) and self.heap[right] > self.heap[largest]:
            largest = right
        if largest != i:
            self.heap[i], self.heap[largest] = self.heap[largest], self.heap[i]
            self.heapify(largest)

    def delete_root(self):
        if len(self.heap) == 0:
            return None
        root_value = self.heap[0]
        last_value = self.heap.pop()
        if len(self.heap) > 0:
            self.heap[0] = last_value
            self.heapify(0)
        return root_value

# Initial key sequence
elements = [3, 25, 9, 35, 10, 13, 1, 7, 46, 2, 51]
max_heap = MaxHeap(elements)

# a) Value in location 5 of the initial heap
value_at_5_initial = max_heap.heap[5]

# b) After deletion of the root and tree restructuring
max_heap.delete_root()
value_at_5_after_deletion = max_heap.heap[5]

value_at_5_initial, value_at_5_after_deletion
def test_max_heap():
    elements = [3, 25, 9, 35, 10, 13, 1, 7, 46, 2, 51]
    max_heap = MaxHeap(elements)

    # a) Value in location 5 of the initial heap
    value_at_5_initial = max_heap.heap[5]
    
    # b) After deletion of the root and tree restructuring
    max_heap.delete_root()
    value_at_5_after_deletion = max_heap.heap[5] if len(max_heap.heap) > 5 else None

    print(f"Value at index 5 of the initial heap: {value_at_5_initial}")
    print(f"Value at index 5 after deletion and restructuring: {value_at_5_after_deletion}")

# Run the test function
test_max_heap()

#Homework Problem 3
def sort_by_color(pairs):
    red = []
    blue = []
    yellow = []

    # Distribute items into respective lists based on color
    for pair in pairs:
        if pair[1] == "red":
            red.append(pair)
        elif pair[1] == "blue":
            blue.append(pair)
        elif pair[1] == "yellow":
            yellow.append(pair)

    # Concatenate the sorted color groups
    return red + blue + yellow

# Test case
pairs = [(1, "blue"), (2, "red"), (3, "red"), (4, "yellow"), (5, "blue"), (6, "yellow"), (7, "red")]
sorted_pairs = sort_by_color(pairs)

# Print output
print(sorted_pairs)

#Problem 5

def preprocess(arr, k):
    freq = [0] * (k + 1)
    prefix = [0] * (k + 1)

    # Count occurrences of each number
    for num in arr:
        freq[num] += 1

    # Build prefix sum array
    for i in range(1, k + 1):
        prefix[i] = prefix[i - 1] + freq[i]

    return prefix

def range_query(prefix, a, b):
    if a > b:
        return 0
    return prefix[b] - prefix[a - 1]

# Test case
arr = [1, 3, 2, 3, 5, 1, 7, 9, 3, 6]
k = 10
prefix = preprocess(arr, k)

# Example queries
print(range_query(prefix, 2, 5))  # Count of numbers in range [2,5]
print(range_query(prefix, 1, 3))  # Count of numbers in range [1,3]
print(range_query(prefix, 6, 9))  # Count of numbers in range [6,9]
