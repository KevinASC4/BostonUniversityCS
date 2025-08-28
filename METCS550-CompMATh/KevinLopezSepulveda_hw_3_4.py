import numpy as np

def gauss_jordan_inverse(A):
    n = A.shape[0]
    # Augment A with identity
    AI = np.hstack((A, np.eye(n)))
    for i in range(n):
        # Make pivot 1
        pivot = AI[i, i]
        if pivot == 0:
            raise ValueError("Pivot zero, cannot invert by this method.")
        AI[i] = AI[i] / pivot
        
        # Eliminate other rows
        for j in range(n):
            if j != i:
                factor = AI[j, i]
                AI[j] = AI[j] - factor * AI[i]
    
    # Right half is inverse
    A_inv = AI[:, n:]
    return A_inv

# Matrix A
A = np.array([[1, 2],
              [3, 4]], dtype=float)

A_inv = gauss_jordan_inverse(A)
print("Inverse of A by Gauss-Jordan method:")
print(A_inv)

# Verify with numpy.linalg.inv
print("\nVerification with numpy.linalg.inv:")
print(np.linalg.inv(A))
