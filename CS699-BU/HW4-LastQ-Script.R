#Libraries
library(caret)
library(kknn) 
library(rsample)
# Load the drug consumption dataset
df <- read.csv("C:/Users/kevMi/OneDrive/Documents/CS699-BU/drug_consumption_cannabis(4).csv")

# Change the class column name
colnames(df)[which(names(df) == "C6")] <- "class"
df$class <- factor(df$class)

# Remove the ID column if necessary
df <- df[, -1]
# Split the dataset into training and testing sets
set.seed(31)
split <- initial_split(df, prop = 0.66, strata = class)
train <- training(split)
test <- testing(split)

# Set up the tuning grid for kknn
kknnGrid <- expand.grid(kmax = seq(1, 20, 2),  # Tune kmax values from 1 to 20
                        distance = c(1, 2),  # 1 for Manhattan, 2 for Euclidean
                        kernel = c("rectangular", "triangular"))  # Different kernels

# Train the kknn model with parameter tuning
set.seed(31)
kknn_model <- train(class ~ ., data = train, method = "kknn", 
                    trControl = trainControl(method = "cv", number = 10),
                    tuneGrid = kknnGrid)
# KNN Model
knn_model <- train(class ~ ., data = train, method = "knn",
                   trControl = trainControl(method = "cv", number = 10),
                   preProcess = c("center", "scale"),
                   tuneLength = 100)

# Make predictions on the test set for KNN
knn_pred <- predict(knn_model, newdata = test)
knn_confusion_matrix <- confusionMatrix(knn_pred, test$class)

# Print KNN Confusion Matrix
print(knn_confusion_matrix)


# Explicitly print the model summary
str(kknn_model)
print(kknn_model)

# Make predictions on the test set
test_pred <- predict(kknn_model, newdata = test)

# Create a confusion matrix
kknn_confusion_matrix <- confusionMatrix(test_pred, test$class)
print(kknn_confusion_matrix)  # Print the confusion matrix
# Compare Performance Metrics
cat("KNN Model Performance:\n")
print(knn_confusion_matrix)

cat("\nkknn Model Performance:\n")
print(kknn_confusion_matrix)
# Save the model as hw4.R
saveRDS(kknn_model, file = "hw4.R")