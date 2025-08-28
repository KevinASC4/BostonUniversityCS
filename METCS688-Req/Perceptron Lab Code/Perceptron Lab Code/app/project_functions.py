"""
     Functions for Perceptron Project


"""

import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt


def perceptron(data, eta, n):
    """
    Frank Rosenblatt's Perceptron Algorithm learns by updating its weights using these simple rules:
        1) If y == 0 (x∈C_1 or x belongs to class C_1 )  &  (z = 𝑤 ∙ x > 0) then update weight W_(n+1) = W_n - ηx
        2) If y == 1 (x∈C_2 or x belongs to class C_2 ) &  (z = 𝑤 ∙ x ≤ 0) then update weight W_(n+1) = W_n+ηx
        3) Otherwise (incorrect classification) keep weight the same W_(n+1)=W_n.
    Here the correction η represents the learning rate.

    :param data: DataFrame containing the x and y values
    :param eta:  Learning Rate of Perceptron
    :param n:    Number of iterations
    :return w:   Learned Weights
    """
    input_vector = data.iloc[:, :-1].to_numpy()  # Input features vector
    classes = data.iloc[:, -1].to_numpy()  # Class corresponding to each feature

    shp = input_vector.shape[1] + 1  # Adding 1 for augmentation of vectors
    w = np.zeros(shape=shp)  # Initial weights
    rows = np.size(input_vector, axis=0)

    for j in range(0, n):
        for i in range(0, rows):
            x = input_vector[i, :]
            x = np.append(x, 1)  # Augmenting 1 to the input vector
            y = classes[i]  # Actual class of input_vector

            z = np.dot(w.transpose(), x)  # Calculating z(x)
            y_hat = 1 if (z > 0) else 0  # Predicted class of input_vector (with the expected output for z)

            # Update weights if y_hat has been predicted wrongly
            if y == 0 and (z > 0):
                w = w - (eta * x)
                # print("- Update")
            elif y == 1 and (z < 0 or z == 0):
                w = w + (eta * x)
                # print("+ Update")

        # print("w for", j + 1, "is", w)

    return w

def plot_data_7(df):
    sns.pairplot(df, hue='classes')
    plt.suptitle("Iris Feature Pair Plots", y=1.02)
    plt.show()
def plot_data_8(df):
    sns.lmplot(x='sepal_length', y='petal_length', hue='classes', data=df, fit_reg=False)
    plt.title("Petal Length vs Sepal Length")
    plt.show()

