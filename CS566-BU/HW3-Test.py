import heapq
import os
import random
import time
from sortedcontainers import SortedList

def sort_and_save_chunk(data, chunk_num, algorithm):
    if algorithm == "quicksort":
        data = quicksort(data)
    elif algorithm == "heapsort":
        data = heapsort(data)
    elif algorithm == "btreesort":
        data = btreesort(data)
    else:  
        data.sort()
    
    filename = f"temp_{chunk_num}.txt"
    with open(filename, "w") as f:
        for number in data:
            f.write(f"{number}\n")
    return filename

def merge_sorted_files(temp_files, output_file):
    min_heap = []
    file_pointers = {}
    
    for file in temp_files:
        f = open(file, "r")
        file_pointers[file] = f
        first_value = f.readline().strip()
        if first_value:
            heapq.heappush(min_heap, (int(first_value), file))
    
    with open(output_file, "w") as out:
        while min_heap:
            smallest, file = heapq.heappop(min_heap)
            out.write(f"{smallest}\n")
            next_value = file_pointers[file].readline().strip()
            if next_value:
                heapq.heappush(min_heap, (int(next_value), file))
    
    for file in temp_files:
        file_pointers[file].close()
        os.remove(file)

def external_sort(input_file, output_file, chunk_size, algorithm="mergesort"):
    temp_files = []
    
    with open(input_file, "r") as f:
        chunk = []
        chunk_num = 0
        
        for line in f:
            chunk.append(int(line.strip()))
            if len(chunk) >= chunk_size:
                temp_files.append(sort_and_save_chunk(chunk, chunk_num, algorithm))
                chunk = []
                chunk_num += 1
        
        if chunk:
            temp_files.append(sort_and_save_chunk(chunk, chunk_num, algorithm))
    
    merge_sorted_files(temp_files, output_file)

def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)

def heapsort(arr):
    heapq.heapify(arr)
    return [heapq.heappop(arr) for _ in range(len(arr))]

def btreesort(arr):
    tree = SortedList()
    for num in arr:
        tree.add(num)
    return list(tree)

def generate_test_file(filename, num_values, value_range):
    with open(filename, "w") as f:
        for _ in range(num_values):
            f.write(f"{random.randint(*value_range)}\n")

def benchmark_sorting_algorithms(input_file, output_file, chunk_size):
    algorithms = ["mergesort", "quicksort", "heapsort", "btreesort"]
    
    for algo in algorithms:
        start_time = time.time()
        external_sort(input_file, output_file, chunk_size, algorithm=algo)
        elapsed_time = time.time() - start_time
        print(f"{algo.capitalize()} completed in {elapsed_time:.2f} seconds")
#generate_test_file("large_numbers.txt", 100000, (0, 1000000))
benchmark_sorting_algorithms("large_numbers.txt", "sorted_output.txt", chunk_size=10000)

