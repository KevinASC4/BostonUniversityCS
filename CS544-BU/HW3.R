library(readr)
library(ggplot2)  # For plotting
# Read the CSV file (adjust the path as needed)
data <- read.csv("CS544-BU/calories_and_cholesterol_amounts.csv")  # Replace with your actual file path
# Separate data for Northside (McDonald's and Burger King)
print(colnames(data))
northside_cholesterol <- data %>%
  filter(Company %in% c("McDonald's", "Burger King")) %>%
  select('Cholesterol..mg.') %>%
  unlist()

# Separate data for Southside (Wendy's and Chick-fil-A)
southside_cholesterol <- data %>%
  filter(Company %in% c("Wendy's", "Chick-fil-A")) %>%
  select('Cholesterol..mg.') %>%
  unlist()
southside_cholesterol <- southside_cholesterol[southside_cholesterol != 285]

# Function to calculate summary statistics
summary_stats <- function(cholesterol_data) {
  c(
    Mean = mean(cholesterol_data),
    Min = min(cholesterol_data),
    Q1 = quantile(cholesterol_data, 0.25),
    Median = median(cholesterol_data),
    Q3 = quantile(cholesterol_data, 0.75),
    Max = max(cholesterol_data),
    Std_Dev = sd(cholesterol_data)
  )
}

# Calculate summary statistics for Northside
northside_stats <- summary_stats(northside_cholesterol)
cat("Summary Statistics for Northside:\n")
print(northside_stats)

# Calculate summary statistics for Southside
southside_stats <- summary_stats(southside_cholesterol)
cat("\nSummary Statistics for Southside:\n")
print(southside_stats)
# Rule #1: Identify outliers based on IQR
Q1 <- quantile(southside_cholesterol, 0.25, na.rm = TRUE)  # First quartile
Q3 <- quantile(southside_cholesterol, 0.75, na.rm = TRUE)  # Third quartile
IQR <- Q3 - Q1  # Interquartile range

# Determine the lower and upper bounds
lower_bound_rule1 <- Q1 - 1.5 * IQR
upper_bound_rule1 <- Q3 + 1.5 * IQR

# Identify outliers for Rule #1
outliers_rule1 <- southside_cholesterol[
  southside_cholesterol< lower_bound_rule1 | 
    southside_cholesterol > upper_bound_rule1
]

# Output Rule #1 Results
cat("Rule #1 Outliers (IQR Method):", outliers_rule1, "\n")

# Rule #2: Identify outliers based on standard deviation
mean_cholesterol <- mean(southside_cholesterol, na.rm = TRUE)
sd_cholesterol <- sd(southside_cholesterol, na.rm = TRUE)

# Determine the lower and upper bounds for outliers
lower_bound_rule2 <- mean_cholesterol - 2 * sd_cholesterol
upper_bound_rule2 <- mean_cholesterol + 2 * sd_cholesterol

# Identify outliers for Rule #2
outliers_rule2 <- southside_cholesterol[
  southside_cholesterol < lower_bound_rule2 | 
    southside_cholesterol > upper_bound_rule2
]

# Output Rule #2 Results
cat("Rule #2 Outliers (Standard Deviation Method):", outliers_rule2, "\n")