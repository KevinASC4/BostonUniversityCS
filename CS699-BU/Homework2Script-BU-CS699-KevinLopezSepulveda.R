library(readr)
library(tidyverse)

#HOMEWORK PROBLEM 2

hw2_p2 <- read.csv("CS699-BU/hw2_p2.csv")
cor_matrix <- cor(hw2_p2)
print(cor_matrix)
# Find the strongest correlation (excluding diagonal values of 1)
cor_matrix[lower.tri(cor_matrix, diag = TRUE)] <- NA  # Remove duplicate and diagonal values
max_cor <- max(abs(cor_matrix), na.rm = TRUE)  # Find the max absolute correlation value
strongest_pair <- which(abs(cor_matrix) == max_cor, arr.ind = TRUE)  # Get variable indices
cat("The strongest correlation is between:", colnames(data)[strongest_pair[1]], "and", colnames(data)[strongest_pair[2]], "with correlation:", max_cor, "\n")

#HOMEWORK PROBLEM 3

# Read the CSV file
hw2_p3 <- read.csv("CS699-BU/hw2_p3.csv")

# Standardize the data using z-score method
standardized_data <- scale(hw2_p3)

# Apply PCA
pca_result <- prcomp(standardized_data, center = TRUE, scale. = TRUE)

# Show summary of PCA results
summary(pca_result)

# Determine number of components needed for 80% and 90% variance
explained_variance <- summary(pca_result)$importance[3, ] # Cumulative proportion of variance
num_pc_80 <- min(which(explained_variance > 0.80))
num_pc_90 <- min(which(explained_variance > 0.90))

# Print results
cat("Number of principal components needed for >80% variance:", num_pc_80, "\n")
cat("Number of principal components needed for >90% variance:", num_pc_90, "\n")

# Show first six tuples of transformed dataset
transformed_data <- as.data.frame(pca_result$x)
head(transformed_data)
