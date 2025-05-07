import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import (
    accuracy_score,
    classification_report,
    confusion_matrix
)
from sklearn.ensemble import RandomForestClassifier
from sklearn.neural_network import MLPClassifier

# Setup for consistent visuals
sns.set(style="whitegrid")

# Load and split dataset
data = load_breast_cancer()
X, y = data.data, data.target
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Scale features
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# 1. Random Forest (as Evolutionary-Inspired Model)
print("Training Random Forest Classifier (baseline for evolutionary approach)...")
rf = RandomForestClassifier(n_estimators=100, random_state=42)
rf.fit(X_train_scaled, y_train)
y_pred_rf = rf.predict(X_test_scaled)

# 2. Neural Network (MLP)
print("\nTraining Neural Network Classifier...")
mlp = MLPClassifier(hidden_layer_sizes=(30, 15), max_iter=1000, random_state=42)
mlp.fit(X_train_scaled, y_train)
y_pred_mlp = mlp.predict(X_test_scaled)

# ------------------------
# CONFUSION MATRIX PLOTS
# ------------------------
def plot_conf_matrix(y_true, y_pred, title):
    cm = confusion_matrix(y_true, y_pred)
    plt.figure(figsize=(5, 4))
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=['No Cancer', 'Cancer'], yticklabels=['No Cancer', 'Cancer'])
    plt.title(f'Confusion Matrix: {title}')
    plt.xlabel('Predicted')
    plt.ylabel('Actual')
    plt.tight_layout()
    plt.show()

plot_conf_matrix(y_test, y_pred_rf, "Random Forest")
plot_conf_matrix(y_test, y_pred_mlp, "Neural Network (MLP)")

# ------------------------
# PERFORMANCE REPORTS
# ------------------------
print("\n--- Random Forest Classification Report ---")
print(classification_report(y_test, y_pred_rf))

print("\n--- Neural Network Classification Report ---")
print(classification_report(y_test, y_pred_mlp))

# ------------------------
# SUMMARY COMPARISON
# ------------------------
acc_rf = accuracy_score(y_test, y_pred_rf)
acc_mlp = accuracy_score(y_test, y_pred_mlp)

print("\n--- Accuracy Summary ---")
print(f"Random Forest Accuracy: {acc_rf:.4f}")
print(f"MLP Accuracy:          {acc_mlp:.4f}")
