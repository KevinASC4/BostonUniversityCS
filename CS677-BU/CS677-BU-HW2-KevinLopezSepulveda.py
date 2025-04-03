'''
Kevin Lopez Sepulveda
CS677
HW2
'''
import numpy as np
#Question 2a
from tqdm import tqdm
import time
#Question 1a
np_array1 = np.arange(25).reshape(5, 5)
print("np_array1:\n", np_array1)
#Question 1b
np_array2 = np.linspace(5.0, 10.0, num=25)
print("np_array2:\n", np_array2)
def matrix_round(arr, precision):
    return np.round(arr, precision)
rounded_array = matrix_round(np_array2, 3)
print("Rounded np_array2:\n", rounded_array)
#Question 1c
# Define the Vandermonde matrix V
V = np.array([[1, 1, 1, 1, 1],
              [1, 2, 4, 16, 32],
              [1, 3, 9, 27, 81],
              [1, 4, 16, 64, 256],
              [1, 5, 25, 125, 625]])
V_inv = np.linalg.inv(V)
print("V_inv:\n", np.round(V_inv, 3))
product1 = np.dot(V_inv, V)
product2 = np.dot(V, V_inv)
print("V_inv * V:\n", np.round(product1, 3))
print("V * V_inv:\n", np.round(product2, 3))
'''
These two are called an identity matrix.
The Numpy command is called np.eye(n) where n is the size of the matrix
'''
#Question 2a
def matrix_multiply_loops(A, B):
    size = len(A)
    result = np.zeros((size, size))
    for i in tqdm(range(size), desc="Multiplying (loops)", unit="row"):
        for j in range(size):
            for k in range(size):
                result[i][j] += A[i][k] * B[k][j]
    return result
matrix_size = 700
A = np.random.rand(matrix_size, matrix_size)
B = np.random.rand(matrix_size, matrix_size)
#Question2b
start_time = time.time()
C_loops = matrix_multiply_loops(A, B)
end_time = time.time()
print(f"Time taken with nested loops: {end_time - start_time:.4f} seconds")
#Question 2c
num_iterations = 30
total_time = 0
for _ in range(num_iterations):
    A = np.random.rand(700, 700)
    B = np.random.rand(700, 700)
    start_time = time.time()
    matrix_multiply_loops(A, B)
    end_time = time.time()
    total_time += (end_time - start_time)
average_time = total_time / num_iterations
print(f"Average time taken for matrix multiplication using nested loops: {average_time:.4f} seconds")
#Question 2d
total_time_numpy = 0
for _ in range(num_iterations):
    A = np.random.rand(700, 700)
    B = np.random.rand(700, 700)
    start_time = time.time()
    np.dot(A, B)
    end_time = time.time()
    total_time_numpy += (end_time - start_time)
average_time_numpy = total_time_numpy / num_iterations
print(f"Average time taken for matrix multiplication using NumPy's dot(): {average_time_numpy:.4f} seconds")
#Question 2e
speedup = average_time / average_time_numpy
print(f"Speedup observed with NumPy: {speedup:.2f} times")