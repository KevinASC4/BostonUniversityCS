# Sample probability distribution
outcomes <- c(0, 1, 2, 3, 4, 5,6,7)
probabilities <- c(0.4, 0.28, 0.16, 0.05, 0.04, 0.03, 0.02, 0.02)

# Rounding the 'times' argument to avoid non-integer values
hist_data <- rep(outcomes, times = round(probabilities * 100))

# Creating a histogram
hist(hist_data, 
     breaks = length(outcomes), 
     col = "skyblue", 
     main = "Histogram of the Probability Distribution", 
     xlab = "Outcomes", 
     ylab = "Frequency", 
     probability = TRUE)

# Adding probability distribution as a line
lines(outcomes, probabilities, type = "b", pch = 19, col = "red")
# Calculating the mean
mean_value <- sum(outcomes * probabilities)
mean_value
# Calculating the standard deviation
std_dev <- sqrt(sum((outcomes - mean_value)^2 * probabilities))
std_dev

# Define profits and probabilities
profits <- c(-90000, 70000, 200000)
probabilities <- c(0.40, 0.45, 0.15)

# Calculate the expected profit
expected_profit <- sum(profits * probabilities)
expected_profit
# Define winnings and probabilities
winnings <- c(50, 10, -5)
probabilities <- c(0.0556, 0.1667, 0.7777)

# Calculate the expected winnings
expected_winnings <- sum(winnings * probabilities)
expected_winnings