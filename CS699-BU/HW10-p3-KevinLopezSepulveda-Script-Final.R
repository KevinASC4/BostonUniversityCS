# Load required libraries
library(forecast)
library(ggplot2)
library(readr)

# (1) Load and plot time series
data <- read_csv("csFiles-BU/BostonUniversityCS/CS699-BU/hw10_p3.csv")
ts_data <- ts(data[[2]], frequency = 12) 

# Plot the time series
autoplot(ts_data) +
  ggtitle("Time Series Plot") +
  ylab("Value") +
  xlab("Time")

# (2) Split into training and validation
n <- length(ts_data)
n_valid <- 16
n_train <- n - n_valid

train_ts <- window(ts_data, end = c(floor((n_train - 1) / 12) + 1, (n_train - 1) %% 12 + 1))
valid_ts <- window(ts_data, start = c(floor(n_train / 12) + 1, n_train %% 12 + 1))

# (3) Linear Trend Model
linear_model <- tslm(train_ts ~ trend)
linear_forecast <- forecast(linear_model, h = n_valid)

autoplot(valid_ts, series="Actual") +
  autolayer(linear_forecast$mean, series="Predicted") +
  ggtitle("Linear Trend Model: Actual vs Predicted")

linear_rmse <- sqrt(mean((linear_forecast$mean - valid_ts)^2))
print(paste("Linear Model RMSE:", round(linear_rmse, 2)))

# (4) Exponential Trend Model
log_train <- log(train_ts)
exp_model <- tslm(log_train ~ trend)
log_forecast <- forecast(exp_model, h = n_valid)
exp_forecast <- exp(log_forecast$mean)

autoplot(valid_ts, series="Actual") +
  autolayer(exp_forecast, series="Predicted") +
  ggtitle("Exponential Trend Model: Actual vs Predicted")

exp_rmse <- sqrt(mean((exp_forecast - valid_ts)^2))
print(paste("Exponential Model RMSE:", round(exp_rmse, 2)))

# (5) Quadratic Trend Model
quad_model <- tslm(train_ts ~ trend + I(trend^2))
quad_forecast <- forecast(quad_model, h = n_valid)

autoplot(valid_ts, series="Actual") +
  autolayer(quad_forecast$mean, series="Predicted") +
  ggtitle("Quadratic Trend Model: Actual vs Predicted")

quad_rmse <- sqrt(mean((quad_forecast$mean - valid_ts)^2))
print(paste("Quadratic Model RMSE:", round(quad_rmse, 2)))

