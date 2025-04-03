# Actual and Predicted values
actual <- c(14.32, 1.19, 30.82, 32.77, 27.89, 7.65, 1.40, 3.60, 46.52, 16.24)
predicted <- c(30.06, 13.70, 50.21, 52.59, 46.64, 21.82, 10.30, 7.10, 69.26, 32.42)

# Calculate errors
errors <- predicted - actual
absolute_errors <- abs(errors)
percentage_errors <- (errors / actual) * 100

# RMSE
RMSE <- sqrt(mean(errors^2))

# MAE
MAE <- mean(absolute_errors)

# MAPE
MAPE <- mean(abs(percentage_errors))

# ME
ME <- mean(errors)

# MPE
MPE <- mean(percentage_errors)

# Print results
cat("RMSE:", RMSE, "\n")
cat("MAE:", MAE, "\n")
cat("MAPE:", MAPE, "%\n")
cat("ME:", ME, "\n")
cat("MPE:", MPE, "%\n")

