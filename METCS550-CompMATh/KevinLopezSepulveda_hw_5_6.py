import scipy.integrate as integrate
import numpy as np

lambd = 1

def integrand(t2):
    return lambd * np.exp(-3 * lambd * t2)

prob, _ = integrate.quad(integrand, 0, np.inf)
print(f"P(T1 >= 2 T2) = {prob}")
