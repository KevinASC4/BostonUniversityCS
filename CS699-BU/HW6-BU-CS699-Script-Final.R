# Load required libraries
library(caret)
library(pROC)
library(naivebayes)
library(nnet)
library(kknn)
library(e1071)  # For SVM

# Load dataset
data <- read.csv("CS699-BU/drug_consumption_cannabis(4).csv")

# Remove missing values
data <- na.omit(data)

# Convert C6 to a factor and rename levels
data$C6 <- factor(data$C6, levels = c(0, 1), labels = c("No", "Yes"))

# Split data into 80% training and 20% testing
set.seed(123)
trainIndex <- createDataPartition(data$C6, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]

# Define training control with cross-validation and ROC metric
train_control <- trainControl(method = "cv",
                              number = 10,
                              savePredictions = "final",
                              classProbs = TRUE,  # Needed for stacking
                              summaryFunction = twoClassSummary)  # Optimize using ROC

# Train Naïve Bayes model
nb_model <- train(C6 ~ ., data = trainData, method = "naive_bayes", 
                  trControl = train_control, metric = "ROC")

# Train Neural Network model
nnet_model <- train(C6 ~ ., data = trainData, method = "nnet", 
                    trControl = train_control, metric = "ROC", trace = FALSE)

# Train KNN model
knn_model <- train(C6 ~ ., data = trainData, method = "kknn", 
                   trControl = train_control, metric = "ROC")

# Train SVM with radial kernel
svm_model <- train(C6 ~ ., data = trainData, method = "svmRadial",
                   trControl = train_control, metric = "ROC")

# Generate predictions from each model (convert probabilities to factors)
nb_preds <- ifelse(predict(nb_model, newdata = testData, type = "prob")[, "Yes"] > 0.5, "Yes", "No")
nnet_preds <- ifelse(predict(nnet_model, newdata = testData, type = "prob")[, "Yes"] > 0.5, "Yes", "No")
knn_preds <- ifelse(predict(knn_model, newdata = testData, type = "prob")[, "Yes"] > 0.5, "Yes", "No")
svm_preds <- ifelse(predict(svm_model, newdata = testData, type = "prob")[, "Yes"] > 0.5, "Yes", "No")

# Convert predictions to factors with correct levels
nb_preds <- factor(nb_preds, levels = levels(testData$C6))
nnet_preds <- factor(nnet_preds, levels = levels(testData$C6))
knn_preds <- factor(knn_preds, levels = levels(testData$C6))
svm_preds <- factor(svm_preds, levels = levels(testData$C6))

# Create confusion matrices for each model
confusion_nb <- confusionMatrix(nb_preds, testData$C6)
confusion_nnet <- confusionMatrix(nnet_preds, testData$C6)
confusion_knn <- confusionMatrix(knn_preds, testData$C6)
confusion_svm <- confusionMatrix(svm_preds, testData$C6)

# Print confusion matrices and calculate sensitivity and specificity
cat("\nConfusion Matrix for Naïve Bayes:\n")
print(confusion_nb$table)
cat("Sensitivity:", confusion_nb$byClass["Sensitivity"], "\n")
cat("Specificity:", confusion_nb$byClass["Specificity"], "\n")

cat("\nConfusion Matrix for Neural Network:\n")
print(confusion_nnet$table)
cat("Sensitivity:", confusion_nnet$byClass["Sensitivity"], "\n")
cat("Specificity:", confusion_nnet$byClass["Specificity"], "\n")

cat("\nConfusion Matrix for KNN:\n")
print(confusion_knn$table)
cat("Sensitivity:", confusion_knn$byClass["Sensitivity"], "\n")
cat("Specificity:", confusion_knn$byClass["Specificity"], "\n")

cat("\nConfusion Matrix for SVM:\n")
print(confusion_svm$table)
cat("Sensitivity:", confusion_svm$byClass["Sensitivity"], "\n")
cat("Specificity:", confusion_svm$byClass["Specificity"], "\n")

# Prepare data for the performance comparison table
model_names <- c("Naive Bayes", "Neural Network", "KNN", "SVM")
sensitivities <- c(
  confusion_nb$byClass["Sensitivity"],
  confusion_nnet$byClass["Sensitivity"],
  confusion_knn$byClass["Sensitivity"],
  confusion_svm$byClass["Sensitivity"]
)

specificities <- c(
  confusion_nb$byClass["Specificity"],
  confusion_nnet$byClass["Specificity"],
  confusion_knn$byClass["Specificity"],
  confusion_svm$byClass["Specificity"]
)

# Build the comparison table
comparison_table <- data.frame(
  Model = model_names,
  Sensitivity = sensitivities,
  Specificity = specificities
)


# Combine predictions into a data frame for stacking
stacked_data <- data.frame(
  nb = nb_preds,
  nnet = nnet_preds,
  knn = knn_preds,
  svm = svm_preds,
  C6 = testData$C6  # Actual labels for the stacked model
)

# Train the stacked model using GLM as meta-learner
stacked_model <- train(C6 ~ ., data = stacked_data, method = "glm",
                       trControl = train_control)

# Test the stacked model
stacked_probs <- predict(stacked_model, newdata = stacked_data, type = "prob")

# Convert predicted probabilities into class labels
stacked_predictions <- ifelse(stacked_probs[, "Yes"] > 0.5, "Yes", "No")
stacked_predictions <- factor(stacked_predictions, levels = levels(testData$C6))

# Check lengths
cat("Length of stacked_predictions:", length(stacked_predictions), "\n")
cat("Length of testData$C6:", length(testData$C6), "\n")

# Create confusion matrix for the stacked model
stacked_cm <- confusionMatrix(stacked_predictions, testData$C6)

# Append stacked model performance to the table
comparison_table <- rbind(comparison_table, data.frame(
  Model = "Stacked Model",
  Sensitivity = stacked_cm$byClass["Sensitivity"],
  Specificity = stacked_cm$byClass["Specificity"]
))

# Print the performance comparison table
cat("\nPerformance Comparison Table:\n")
print(comparison_table)

# Check if the performance of the stacked model is better
is_better <- all(comparison_table$Sensitivity[comparison_table$Model != "Stacked Model"] < stacked_cm$byClass["Sensitivity"]) &&
  all(comparison_table$Specificity[comparison_table$Model != "Stacked Model"] < stacked_cm$byClass["Specificity"])

cat("\nIs the performance of the stacked model better than the performances of individual models? ", is_better, "\n")


# Print results
cat("\nConfusion Matrix for Stacked Model:\n")
print(stacked_cm$table)
cat("Sensitivity:", stacked_cm$byClass["Sensitivity"], "\n")
cat("Specificity:", stacked_cm$byClass["Specificity"], "\n")

# Plot ROC curves for all models
roc_data <- roc(testData$C6, stacked_probs[, "Yes"])
plot(roc_data, col = "blue", main = "ROC Curves for Models")
lines(roc(testData$C6, predict(nb_model, testData, type = "prob")[, "Yes"]), col = "red")
lines(roc(testData$C6, predict(nnet_model, testData, type = "prob")[, "Yes"]), col = "green")
lines(roc(testData$C6, predict(knn_model, testData, type = "prob")[, "Yes"]), col = "purple")
lines(roc(testData$C6, predict(svm_model, testData, type = "prob")[, "Yes"]), col = "orange")
legend("bottomright", legend = c("Stacked", "NB", "NNET", "KNN", "SVM"), 
       col = c("blue", "red", "green", "purple", "orange"), lwd = 2)
