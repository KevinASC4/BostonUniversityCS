"""
    Program: Iris Flower Dataset Classification Project using Perceptron
        Demonstrates how to use Perceptron as a defined function to classify Iris Dataset.

    Data: Iris Dataset



"""

from app import project_functions as pf
import pandas as pd
import numpy as np
from random import randrange


if __name__ == '__main__':

    # Create a variable iris_data_url and pass to it the following
    # URL: 'https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data'
    # Next load the Iris dataset from this URL
    iris_data_url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data'
    # Define the column names because the dataset does not include a header row
    column_names = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width', 'classes']

    # Load the Iris dataset from the URL into a pandas DataFrame
    iris_df = pd.read_csv(iris_data_url, header=None, names=column_names)
    iris_df_raw = pd.read_csv(iris_data_url)

    # Display the first few rows to confirm it loaded correctly
    print(iris_df.head())
    # Q1: What is the number of rows of this data frame?
    print(f"Number of rows: {len(iris_df)}")

    # Q2: What is the name of the second column?
    print("Name of the second column before change: ", iris_df_raw.columns[1])

    # 3) Rename the columns of the dataframe to the following
    # Q3: What is the name of the second column now?
    print("Name of the second column after change:", iris_df.columns[1])

    # 4) Create a variable "classes" which contains the unique value of the fifth column
    # Q4: How many different classes are there?
    classes = iris_df['classes'].unique()
    print("Unique classes:", classes)

    # 5) Visualize Data by creating a function
    # Visualize the whole dataset
    # Q5: Which flower ('Class_labels') has the longest ....?
    # Find the class with the longest average sepal length
    longest_sepal = iris_df.groupby('classes')['sepal_length'].mean().idxmax()
    print("Flower with the longest sepal length:", longest_sepal)
    # 6) Modify your code from the previous question to find the value of the shortest ...
    # Q6: Which flower ('Class_labels') has the longest 'Sepal length'?
    shortest_sepal = iris_df.groupby('classes')['sepal_length'].mean().idxmin()
    print("Q6 Answer - Flower with the shortest sepal length:", shortest_sepal)

    # Q7: From the visualization plot, the class ... is well separated from the other two flowers
    # by which feature?
    pf.plot_data_7(iris_df)
    print("The class Iris-setosa is well separated from the others by petal length.")
    # Q8:In the python script “project_functions.py” create a function “plot_data” containing the given code.
    # Then insert code in your script “main_perceptron_lab.py” to plot Petal vs Sepal Length:
    pf.plot_data_8(iris_df)



    # 9) Determine Training Weights of Perceptron
    # Choose features and labels. Specify Learning rate
    # Create dataframe to train the Perceptron on half of the data
    # Select 2 classes for binary classification
    binary_df = iris_df[iris_df['classes'].isin(['Iris-setosa', 'Iris-versicolor'])].copy()

    # Map class labels to binary: 0 for setosa, 1 for versicolor
    binary_df['label'] = binary_df['classes'].map({'Iris-setosa': 0, 'Iris-versicolor': 1})

    # Use petal length and sepal length as features
    features = binary_df[['petal_length', 'sepal_length']]
    labels = binary_df[['label']]
    data = pd.concat([features, labels], axis=1)

    # Shuffle and take half the data
    data = data.sample(frac=1).reset_index(drop=True)
    half_data = data.iloc[:len(data)//2]

    # Q9: What are the weights learned by the perceptron?
    # Train perceptron
    weights = pf.perceptron(half_data, eta=0.1, n=10)
    print("Q9 Answer - Learned Weights:", weights)


    # Q10: Make classification predictions with learned weights of the perceptron, using the given code.
    # Hold-out data for testing
    test_data = data.iloc[len(data)//2:]

    correct = 0
    for _, row in test_data.iterrows():
        x = np.array([row['petal_length'], row['sepal_length'], 1])  # include bias
        z = np.dot(weights, x)
        pred = 1 if z > 0 else 0
        if pred == row['label']:
            correct += 1

    accuracy = correct / len(test_data)
    print("Q10 Answer - Prediction Accuracy:", accuracy)




    print("End")