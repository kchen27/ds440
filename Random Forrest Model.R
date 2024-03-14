library(readr)
library(dplyr)
library(tidyr)
library(caret)
library(forecast)
library(tseries)
library(randomForest)

# Load dataset
df <- read_csv("CPIAUCSL.csv")

# Handle missing values
df <- df %>% mutate(across(everything(), ~ifelse(is.na(.), mean(., na.rm = TRUE), .)))

# Encode categorical variables
df <- df %>% mutate(across(c('City', 'Property Type', 'Room Type'), as.factor))

# Normalize/Standardize numerical features
df$Price <- scale(df$Price)
df$`Minimum nights` <- scale(df$`Minimum nights`)
df$`Number of Rooms` <- scale(df$`Number of Rooms`)

# Determine d value using ADF test
adf.test(df$Price)

# Fit ARIMA model (p, d, q values need to be optimized)
auto_arima <- auto.arima(df$Price, stepwise = FALSE, approximation = FALSE)

# Summary of the model
summary(auto_arima)

set.seed(123)  # For reproducibility
timeSlices <- createTimeSlices(1:nrow(df), initialWindow = 4, horizon = 1, fixedWindow = TRUE, skip = 0)

for(i in 1:length(timeSlices$train)){
  trainSlices <- timeSlices$train[[i]]
  testSlices <- timeSlices$test[[i]]
  
  trainData <- df[trainSlices, ]
  testData <- df[testSlices, ]
  
  # Fit the model on trainData
  # model_fit <- auto.arima(trainData$Price, stepwise = FALSE, approximation = FALSE)
  
  # Predict on testData
  # predictions <- forecast(model_fit, h = nrow(testData))
  
  # Calculate metrics, e.g., RMSE
  # rmse <- sqrt(mean((testData$Price - predictions$mean)^2))
  # print(paste('Test RMSE:', rmse))
}

