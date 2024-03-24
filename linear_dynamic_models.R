library(readr)
library(dplyr)
library(lubridate)
library(tidyverse)
library(dynlm)

set.seed(123)
sampled_data <- filtered[sample(nrow(filtered), size = floor(0.2 * nrow(filtered))),]

## NOTES:
### No residuals, overfitting the data, aggregate some categories
linear_model <- lm (Price ~ Price + Bedrooms + Bathrooms + Beds + Guests.Included + 
                      Review.Scores.Rating + Review.Scores.Accuracy + Review.Scores.Cleanliness +
                      Review.Scores.Checkin + Review.Scores.Communication + Review.Scores.Location +
                      Review.Scores.Value + Year, data = sampled_data)

summary(linear_model)

# Random forest
# The effects of each covariets with change of time
# Consumer index inflation model/predict inflation 
# Feeding the model inflation index
# Cross sectional model/ Inflation

# Initial process start off with just prediction based on the factors and include inflations later on
# 



dynamic_model <- dynlm( Price ~ L(Price, 1) City + Bedrooms + Bathrooms + Beds + Guests.Included + 
                          Review.Scores.Rating + Review.Scores.Accuracy + Review.Scores.Cleanliness +
                          Review.Scores.Checkin + Review.Scores.Communication + Review.Scores.Location +
                          Review.Scores.Value + Year, data = sampled_data)
summary(dynamic_model)