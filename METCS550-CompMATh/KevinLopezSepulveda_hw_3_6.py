import numpy as np

def solve_and_print(A, b, system_num):
    print(f"\nSystem {system_num} solution:")
    det = np.linalg.det(A)
    print(f"Determinant: {det:.4f}")

    rank_A = np.linalg.matrix_rank(A)
    Ab = np.hstack((A, b.reshape(-1, 1)))
    rank_Ab = np.linalg.matrix_rank(Ab)

    print(f"Rank of A: {rank_A}")
    print(f"Rank of augmented [A|b]: {rank_Ab}")

    if rank_A == rank_Ab:
        if rank_A == A.shape[1]:
            # Unique solution
            try:
                solution = np.linalg.solve(A, b)
                for i, val in enumerate(solution):
                    print(f"x{i+1} = {val}")
            except np.linalg.LinAlgError:
                print("Error solving the system.")
        else:
            # Infinite solutions - print least squares solution as one example
            print("Infinite solutions exist. Showing one least squares solution:")
            solution, residuals, _, _ = np.linalg.lstsq(A, b, rcond=None)
            for i, val in enumerate(solution):
                print(f"x{i+1} ≈ {val}")
            if residuals.size > 0:
                print(f"Residuals: {residuals}")
    else:
        print("No solution exists (system is inconsistent).")

# System 1: 2x + 3y = 8; 2x - y = 0
A1 = np.array([[2, 3],
               [2, -1]], dtype=float)
b1 = np.array([8, 0], dtype=float)
solve_and_print(A1, b1, 1)

# System 2: x + 2y = -2; 2x + y = 2
A2 = np.array([[1, 2],
               [2, 1]], dtype=float)
b2 = np.array([-2, 2], dtype=float)
solve_and_print(A2, b2, 2)

# System 3:
# 2x + 3y + 4z = 4
# x - y + z = 1
# 2x - y + z = 1
A3 = np.array([[2, 3, 4],
               [1, -1, 1],
               [2, -1, 1]], dtype=float)
b3 = np.array([4, 1, 1], dtype=float)
solve_and_print(A3, b3, 3)

# System 4:
# x + y + z = 1
# 2x + y + z = 2
# x + 2y + 2z = 1
A4 = np.array([[1, 1, 1],
               [2, 1, 1],
               [1, 2, 2]], dtype=float)
b4 = np.array([1, 2, 1], dtype=float)
solve_and_print(A4, b4, 4)
