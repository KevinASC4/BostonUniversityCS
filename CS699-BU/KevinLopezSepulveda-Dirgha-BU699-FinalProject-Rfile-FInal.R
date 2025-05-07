# Load necessary libraries
library(tidyverse)
library(caret)
library(e1071)  # For additional classification models
library(randomForest)
library(nnet)
library(rpart)
library(pROC)  # For ROC analysis
# Load necessary libraries for visualization
library(ggplot2)
library(gridExtra)

# Load the dataset
data <- read.csv("C:/Users/kevMi/OneDrive/Documents/csFiles-BU/BostonUniversityCS/CS699-BU/project_data.csv")

# Drop columns with more than 50% missing values
data <- data[, colMeans(!is.na(data)) > 0.5]

# Convert the target variable 'Class' to a factor
data$Class <- as.factor(data$Class)

# Handle missing values (simple imputation example)
data[is.na(data)] <- 0  # You can choose a different method of imputation

# Scale numeric features (excluding the target variable)
numeric_data <- data %>% select(-Class) %>% select(where(is.numeric))

# Check if there are numeric columns for scaling
if (ncol(numeric_data) == 0) {
  stop("Error: No numeric columns available for scaling.")
}

# Scale the numeric features
pre_proc <- preProcess(numeric_data, method = c("center", "scale"))
data_scaled <- predict(pre_proc, newdata = numeric_data)

# Combine scaled features with the target variable
data_processed <- cbind(data_scaled, Class = data$Class)

# Split the dataset into training and testing sets
set.seed(123)  # For reproducibility
train_index <- createDataPartition(data_processed$Class, p = 0.8, list = FALSE)
train_data <- data_processed[train_index, ]
test_data <- data_processed[-train_index, ]

# Balancing methods
# 1. Undersampling
undersample <- function(data) {
  majority_class <- data %>% filter(Class == "No")
  minority_class <- data %>% filter(Class == "Yes")
  
  # Randomly sample the majority class
  majority_downsampled <- majority_class %>% sample_n(nrow(minority_class))
  
  # Combine minority and downsampled majority
  return(rbind(majority_downsampled, minority_class))
}

# 2. Oversampling
oversample <- function(data) {
  majority_class <- data %>% filter(Class == "No")
  minority_class <- data %>% filter(Class == "Yes")
  
  # Randomly sample with replacement the minority class
  minority_upsampled <- minority_class %>% sample_n(nrow(majority_class), replace = TRUE)
  
  # Combine majority and upsampled minority
  return(rbind(majority_class, minority_upsampled))
}

# Create balanced datasets using undersampling and oversampling
train_data_undersampled <- undersample(train_data)
train_data_oversampled <- oversample(train_data)

# Initialize a list to store confusion matrices and metrics
results <- list()

# Function to train and evaluate model
evaluate_model <- function(model_name, train_data) {
  model <- train(Class ~ ., data = train_data, method = model_name, trControl = trainControl(method = "none"))
  predictions <- predict(model, newdata = test_data)
  confusion_matrix <- confusionMatrix(predictions, test_data$Class)
  
  # Calculate additional performance metrics
  performance_metrics <- list(
    confusion_matrix = confusion_matrix$table,
    accuracy = confusion_matrix$overall["Accuracy"],
    sensitivity = confusion_matrix$byClass["Sensitivity"],
    specificity = confusion_matrix$byClass["Specificity"],
    precision = confusion_matrix$byClass["Precision"],
    recall = confusion_matrix$byClass["Recall"],
    F1 = confusion_matrix$byClass["F1"],
    ROC_AUC = as.numeric(roc(test_data$Class, as.numeric(predictions))$auc)  # Convert AUC to numeric
  )
  
  return(performance_metrics)
}

# Train and evaluate models with both undersampled and oversampled training data
models <- c("glm", "rpart", "rf", "nnet")  # Add more models as needed

for (model in models) {
  cat("\nEvaluating model:", model, "with undersampling:\n")
  results[[paste(model, "undersampled", sep = "_")]] <- evaluate_model(model, train_data_undersampled)
  
  cat("\nEvaluating model:", model, "with oversampling:\n")
  results[[paste(model, "oversampled", sep = "_")]] <- evaluate_model(model, train_data_oversampled)
}

# Display confusion matrices and metrics for all models
for (result_name in names(results)) {
  cat("\nConfusion Matrix for", result_name, ":\n")
  print(results[[result_name]]$confusion_matrix)
  cat("\nPerformance Metrics for", result_name, ":\n")
  cat("Accuracy:", results[[result_name]]$accuracy, "\n")
  cat("Sensitivity:", results[[result_name]]$sensitivity, "\n")
  cat("Specificity:", results[[result_name]]$specificity, "\n")
  cat("Precision:", results[[result_name]]$precision, "\n")
  cat("Recall:", results[[result_name]]$recall, "\n")
  cat("F1 Score:", results[[result_name]]$F1, "\n")
  cat("ROC AUC:", results[[result_name]]$ROC_AUC, "\n")
}

# Create a data frame for easy plotting
metrics_summary <- do.call(rbind, lapply(names(results), function(result_name) {
  data.frame(
    Model = result_name,
    Accuracy = results[[result_name]]$accuracy,
    Sensitivity = results[[result_name]]$sensitivity,
    Specificity = results[[result_name]]$specificity,
    Precision = results[[result_name]]$precision,
    Recall = results[[result_name]]$recall,
    F1 = results[[result_name]]$F1,
    ROC_AUC = results[[result_name]]$ROC_AUC
  )
}))

# Now use pivot_longer to transform the metrics for visualization
metrics_long <- metrics_summary %>%
  pivot_longer(cols = -Model, names_to = "Metric", values_to = "Value")

# Create a ggplot for visualization
ggplot(metrics_long, aes(x = Model, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Model Performance Comparison", x = "Model", y = "Value") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save preprocessed datasets
write.csv(data_processed, "preprocessed_data.csv", row.names = FALSE)
write.csv(train_data, "initial_train.csv", row.names = FALSE)
write.csv(test_data, "initial_test.csv", row.names = FALSE)

# Save results to an RDS file if needed
saveRDS(results, "model_results.rds")
