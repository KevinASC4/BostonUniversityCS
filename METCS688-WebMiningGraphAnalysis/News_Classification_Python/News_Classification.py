# https://towardsml.com/2019/09/17/bert-explained-a-complete-guide-with-theory-and-tutorial/
"""
 4) Using TFIDF for multi-class Text Classification of the 20 Newsgroups dataset

"""

from joblib import dump, load
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer, CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.datasets import fetch_20newsgroups
from sklearn.model_selection import train_test_split
from sklearn import preprocessing

from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.neural_network import MLPClassifier
from sklearn.naive_bayes import GaussianNB, BernoulliNB, MultinomialNB
from sklearn.neighbors import KNeighborsClassifier
import xgboost as xgb
from sklearn.metrics import classification_report, confusion_matrix
from sklearn import metrics
import random

random.seed(0)


def model_train(features_train, tags_train, model_name, models_path):
    """ Train Classifier ML Model """
    # tags_train = tags_train['Tag']

    if model_name == "model_nn.joblib":
        model = MLPClassifier(hidden_layer_sizes=(10, 10, 10), max_iter=500, random_state=1,  # 1) Use NN Model Classifier (24/67)
                              solver='adam',  # solver{‘lbfgs’, ‘sgd’, ‘adam’} default=’adam’
                              activation='relu')  # activation{‘identity’, ‘logistic’, ‘tanh’, ‘relu’}, default=’relu’
    elif model_name == "model_nb.joblib":
        model = GaussianNB()  # 2) Use Naive Bayes Classifier
    elif model_name == "model_nbb.joblib":
        model = BernoulliNB()  # 3) Use Bernoulli Naive Bayes Classifier
    elif model_name == "model_mnb.joblib":
        model = MultinomialNB()  # 4) Use Multinomial Naive Bayes Classifier
    elif model_name == "model_knn.joblib":
        model = KNeighborsClassifier(n_neighbors=2)  # 5) Use KNN
    elif model_name == "model_rf.joblib":
        model = RandomForestClassifier(n_estimators=100, random_state=0)  # 6) Use Random Forest Classifier (criterion: 'gini', 'entropy')
    elif model_name == "model_lr.joblib":
        model = LogisticRegression(solver='liblinear')  # 7) Use Logistic Regression Classifier (solver: newton-cg, lbfgs, liblinear, sag, saga)
    elif model_name == "model_svm.joblib":
        model = SVC(kernel='rbf', gamma='auto', probability=True)  # 8) Use SVM with Probability Classifier (kernels: linear, poly, rbf, sigmoid
    elif model_name == "model_svm1.joblib":
        # high C aims at classifying all training examples correctly. gamma defines how much influence a single training example has
        model = SVC(kernel='rbf', random_state=1, gamma=0.001, C=20)  # 9) Use SVM with "rbf" Kernel Classifier
    elif model_name == "model_xgb.joblib":
        model = xgb.XGBClassifier(colsample_bytree=0.7, gamma=0, learning_rate=0.2, max_depth=7, reg_alpha=0, reg_lambda=1, subsample=0.8)  # 10) XGB
    else:
        print(" ~~~ Wrong Model Name!!! ~~~~ ")
        pass

    labels = preprocessing.LabelEncoder()
    tags_train = labels.fit_transform(tags_train)

    model.fit(features_train, tags_train)  # Train the model on the training features
    # dump(model, models_path + model_name)  # Save the model

    return model


def model_test(model, features_test, tags_test):
    labels = preprocessing.LabelEncoder()
    tags_test_fit = labels.fit_transform(tags_test)

    predicted_test, accuracy_test, precision_test, recall_test, f1_test, cm_test = calculate_metrics(model, features_test,  tags_test_fit)
    return predicted_test, accuracy_test, precision_test, recall_test, f1_test, cm_test


def calculate_metrics(model, features, tags):
    """ Calculate Classification Effectiveness """
    predictions = model.predict(features)
    accuracy = metrics.accuracy_score(tags, predictions)  # model accuracy
    precision = metrics.precision_score(tags, predictions)  # model precision
    recall = metrics.recall_score(tags, predictions)  # model recall
    f1_score = metrics.f1_score(tags, predictions)  # model f1_score
    cm = confusion_matrix(tags, predictions)  # creating a confusion matrix
    tn, fp, fn, tp = confusion_matrix(list(tags), list(predictions), labels=[0, 1]).ravel()  # Get TN, FP, FN, TP
    row_names, col_names = ["Actual Negative", "Actual Positive"], ["Predict Negative", "Predict Positive"]
    cm = pd.DataFrame(cm, index=pd.Index(row_names), columns=pd.Index(col_names))
    return predictions, accuracy, precision, recall, f1_score, cm

#
# def print_metrics(title, tags, accuracy, precision, recall, f1_score, cm, predicted):
#     """ Print Classification Effectiveness """
#     print(title, "contains", len(tags.loc[tags == 0]), "Negatives (Others) and", len(tags.loc[tags == 1]), "Positives (Major Decrease)")
#     print("Accuracy:", round(accuracy * 100, 1), "%")
#     print("Precision:", round(precision * 100, 1), "%")
#     print("Recall:", round(recall * 100, 1), "%")
#     print("F1-Score:", round(f1_score * 100, 1), "%")
#     # print("Confusion Matrix", cm)
#     cm_data = {"Predict Other": ['TN', 'FN'],  # First Column
#                "Predict MD": ['FP', 'TP']}  # Second Column
#     row_names, col_names = ["Actual Other", "Actual MD"], ["Predict Other", "Predict MD"]
#     CM = pd.DataFrame(cm_data, index=pd.Index(row_names), columns=pd.Index(col_names))
#     print(CM)
#     print(cm)
#     # print(classification_report(y_true=tags, y_pred=predicted))
#     print(" =========================================")
#     return True


def classify_ng(model_name, transfer, x_train, x_test, y_train, y_test):
    x_train = transfer.fit_transform(x_train)  # Vectorize Train
    x_test = transfer.transform(x_test)  # Vectorize Test

    model = model_train(x_train, y_train, model_name, models_path="")  # Train Model
    predicted_test, accuracy_test, precision_test, recall_test, f1_test, cm_test = model_test(model, x_test, y_test)
    return predicted_test, accuracy_test, precision_test, recall_test, f1_test, cm_test


def print_scores(accuracy_test, precision_test, recall_test, f1_test, cm_test):
    print("Accuracy:", round(accuracy_test * 100, 1), "%")
    print("Precision:", round(precision_test * 100, 1), "%")
    print("Recall:", round(recall_test * 100, 1), "%")
    print("F1-Score:", round(f1_test * 100, 1), "%")
    cm_data = {"Predict Negative": ['TN', 'FN'],  # First Column
               "Predict Positive": ['FP', 'TP']}  # Second Column
    row_names, col_names = ["Actual Negative", "Actual Positive"], ["Predict Negative", "Predict Positive"]
    CM = pd.DataFrame(cm_data, index=pd.Index(row_names), columns=pd.Index(col_names))
    print(CM)
    print(cm_test)
    return True


categories = ['sci.space', 'rec.autos']
newsgroups = fetch_20newsgroups(subset="all", categories=categories)
x_train, x_test, y_train, y_test = train_test_split(newsgroups.data, newsgroups.target)
x_train, x_test, y_train, y_test = x_train[0:100], x_test[0:100], y_train[0:100], y_test[0:100]

# "model_nn", "model_nb", "model_nbb", "model_mnb", "model_knn", "model_rf", "model_lr", "model_svm", "model_svm", SVM with "rbf", "model_xgb"
model_name = "model_knn.joblib"
predicted_test, accuracy_test, precision_test, recall_test, f1_test, cm_test = classify_ng(model_name, CountVectorizer(), x_train, x_test, y_train, y_test)  # 1) Use TDM
print("======== DTM =======")
print("Model:" + model_name)
print_scores(accuracy_test, precision_test, recall_test, f1_test, cm_test)

predicted_test, accuracy_test, precision_test, recall_test, f1_test, cm_test = classify_ng(model_name, TfidfVectorizer(), x_train, x_test, y_train, y_test)  # 2) Use TFIDF
print("======== TFIDF ========")
print("Model:" + model_name)
print_scores(accuracy_test, precision_test, recall_test, f1_test, cm_test)

print("Stop")

# Importing the necessary BERT modules
# from transformers import BertTokenizerFast, BertForSequenceClassification
# from transformers import Trainer, TrainingArguments


#  For each token, calculate Naive Bayes conditional probability of that token given each class
nb = MultinomialNB()  # Instantiate a Multinomial Naive Bayes model

vect = CountVectorizer()  # Instantiate DTM vectorizer
dtm = vect.fit_transform(x_train)  # Create DTM
train_tokens = vect.get_feature_names()  # Store train data vocabulary

nb.fit(dtm, y_train)  # train the model

# number of times each token appears across all HAM messages
neg_token_count = nb.feature_count_[0, :]  # First row - number of times each token appears across all Negative messages
pos_token_count = nb.feature_count_[1, :]  # Second row - number of times each token appears across all Positive messages

# Create a DataFrame of tokens with their separate Negative/Positive counts
tokens = pd.DataFrame({'token': train_tokens, 'Neg': neg_token_count, 'Pos': pos_token_count}).set_index('token')
tokens.head()
tokens.sample(5, random_state=6)  # Sample DF rows
nb.class_count_  # Naive Bayes counts the number of observations in each class

# Avoid dividing by zero and account for the class imbalance.
tokens['Neg'] = tokens.Neg + 1  # Add 1 to counts to avoid dividing by 0
tokens['Pos'] = tokens.Pos + 1  # Add 1 to counts to avoid dividing by 0
tokens.sample(5, random_state=6)

# Convert the Neg/Pos counts into frequencies
tokens['Neg'] = tokens.Neg / nb.class_count_[0]
tokens['Pos'] = tokens.Pos / nb.class_count_[1]
tokens.sample(5, random_state=6)

# Calculate the Pos-to-Neg ratio for each token
tokens['Pos_ratio'] = tokens.Pos / tokens.Neg
tokens.sample(5, random_state=6)

tokens.sort_values('Pos_ratio', ascending=False)  # examine the DataFrame sorted by spam_ratio

tokens.loc['shuttle', 'Pos_ratio'] # look up the spam_ratio for a given token

# Tuning the vectorizer such as: stop_words, ngram_range
vect = CountVectorizer(stop_words='english', ngram_range=(1, 2))  # include 1-grams and 2-grams
vect = CountVectorizer(max_df=0.5)  # ignore terms that appear in more than 50% of the documents
vect = CountVectorizer(min_df=2)  # only keep terms that appear in at least 2 documents


print("End")
