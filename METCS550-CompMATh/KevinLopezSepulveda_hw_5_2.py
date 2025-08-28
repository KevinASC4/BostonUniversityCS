def ensemble_accuracy(p):
    return p**2 * (3 - 2*p)

p = 0.7
acc = ensemble_accuracy(p)
print(f"Ensemble accuracy for p={p}: {acc}")
