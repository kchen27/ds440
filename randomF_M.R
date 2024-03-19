library(readr)
library(dplyr)
library(lubridate)
library(tidyverse)
library(randomForest) 

### Load data
inflation <- read.csv("CPIAUCSL.csv")

# Split data into training and testing sets
set.seed(42) # for reproducibility
train_indices <- sample(1:nrow(inflation), 0.8 * nrow(inflation))
train_data <- inflation[train_indices, ]
test_data <- inflation[-train_indices, ]

# Create and train the Random Forest model
rf_model <- randomForest(formula = CPIAUCSL ~ ., data = train_data, ntree = 100)

# Make predictions on the testing data
predictions <- predict(rf_model, newdata = test_data)
print(predictions)
summary(predictions)