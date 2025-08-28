import sympy as sp

# Define symbol
x = sp.symbols('x', real=True)

# 1️ f(x) = exp(-(x+1)**2)
f = sp.exp(-(x+1)**2)
# derivative
f_prime = sp.diff(f, x)
# Solve f'(x) = 0
crit_f = sp.solve(f_prime, x)
# Evaluate function at critical points
f_values = [f.subs(x, c).evalf() for c in crit_f]
f_min_value = min(f_values)
f_min_point = crit_f[f_values.index(f_min_value)]

print("f(x) = exp(-(x+1)^2)")
print("Critical point(s):", crit_f)
print("Minimum value (approached as x→±∞): 0")
print("Maximum value at x =", f_min_point, "is", f_min_value)
print("\n")


# 3️ h(x) = (x-2)**4 + (x-1)**2
import sympy as sp

x = sp.symbols('x', real=True)
h = (x-2)**4 + (x-1)**2
h_prime = sp.diff(h, x)

# Solve derivative = 0 and keep only real solutions
crit_h_all = sp.solve(h_prime, x)
crit_h_real = [c.evalf() for c in crit_h_all if sp.im(c) == 0]  # filter real

# Evaluate function at real critical points
h_values = [h.subs(x, c).evalf() for c in crit_h_real]
h_min_value = min(h_values)
h_min_point = crit_h_real[h_values.index(h_min_value)]

print("h(x) = (x-2)^4 + (x-1)^2")
print("Real critical points:", crit_h_real)
print("Function values at critical points:", h_values)
print("Minimum value:", h_min_value, "at x =", h_min_point)
