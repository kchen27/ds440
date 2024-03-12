library(readr)
library(dplyr)
library(lubridate)
library(tidyverse)
library(dynlm)

### Load data
airbnb_data <- read.csv("airbnb-modified.csv")

## Listing Year and Quarter
airbnb_data$Last.Review <- ymd(airbnb_data$Last.Review)

airbnb_data <- airbnb_data %>%
  mutate(Year = year(Last.Review),
         Quarter = quarter(Last.Review))

## Further cleaning to only United States

filtered <- subset(airbnb_data, Country == "United States")

Austin <- subset(filtered, City == "Austin")
NY <- subset(filtered, City == "New York")
LA <- subset(filtered, City == "Los Angeles")
Denver <- subset(filtered, City == "Denver")
Boston <- subset(filtered, City == "Boston")
Chicago <- subset(filtered, City == "Chicago")

set.seed(123)
sampled_data <- filtered[sample(nrow(filtered), size = floor(0.2 * nrow(filtered))),]

linear_model <- lm (Price ~ Name + City + Bedrooms + Bathrooms + Beds + Guests.Included + 
                      Review.Scores.Rating + Review.Scores.Accuracy + Review.Scores.Cleanliness +
                      Review.Scores.Checkin + Review.Scores.Communication + Review.Scores.Location +
                      Review.Scores.Value + Year, data = sampled_data)

summary(linear_model)

dynamic_model <- dynlm( Price ~ L(Price, 1) + Name + City + Bedrooms + Bathrooms + Beds + Guests.Included + 
                          Review.Scores.Rating + Review.Scores.Accuracy + Review.Scores.Cleanliness +
                          Review.Scores.Checkin + Review.Scores.Communication + Review.Scores.Location +
                          Review.Scores.Value + Year, data = sampled_data)
summary(dynamic_model)