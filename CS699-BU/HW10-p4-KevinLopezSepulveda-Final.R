# Load required libraries
library(forecast)
library(ggplot2)
library(readr)
library(tseries)

# (1) Load data and plot time series
data <- read_csv("csFiles-BU/BostonUniversityCS/CS699-BU/hw10_p4.csv")  # Change if your path is different
ts_data <- ts(data[[2]], frequency = 12)  # Assuming values are in column 2

autoplot(ts_data) +
  ggtitle("Time Series Plot") +
  xlab("Time") +
  ylab("Value")

# (2) Decompose time series
decomp <- decompose(ts_data)
autoplot(decomp)

# (3) Split into training and validation
n <- length(ts_data)
n_valid <- 16
n_train <- n - n_valid

train_ts <- window(ts_data, end = c(floor((n_train - 1) / 12) + 1, (n_train - 1) %% 12 + 1))
valid_ts <- window(ts_data, start = c(floor(n_train / 12) + 1, n_train %% 12 + 1))

# (4) Quadratic trend + seasonality model
quad_season_model <- tslm(train_ts ~ trend + I(trend^2) + season)
quad_season_forecast <- forecast(quad_season_model, h = n_valid)

autoplot(valid_ts, series="Actual") +
  autolayer(quad_season_forecast$mean, series="Predicted") +
  ggtitle("Quadratic Trend + Seasonality Model")

quad_season_rmse <- sqrt(mean((quad_season_forecast$mean - valid_ts)^2))
print(paste("Quadratic Trend + Seasonality RMSE:", round(quad_season_rmse, 2)))

# (5) Holt-Winters (Triple Exponential Smoothing)
hw_model <- hw(train_ts, seasonal = "additive", h = n_valid)
autoplot(valid_ts, series="Actual") +
  autolayer(hw_model$mean, series="Predicted") +
  ggtitle("Holt-Winters Model")

hw_rmse <- sqrt(mean((hw_model$mean - valid_ts)^2))
print(paste("Holt-Winters RMSE:", round(hw_rmse, 2)))

# (6) Auto ARIMA
arima_auto <- auto.arima(train_ts)
print("Auto ARIMA Best Parameters:")
print(arima_auto)

# (7) ARIMA model with best parameters
arima_forecast <- forecast(arima_auto, h = n_valid)
autoplot(valid_ts, series="Actual") +
  autolayer(arima_forecast$mean, series="Predicted") +
  ggtitle("ARIMA Model with Auto Parameters")

arima_rmse <- sqrt(mean((arima_forecast$mean - valid_ts)^2))
print(paste("ARIMA RMSE:", round(arima_rmse, 2)))
