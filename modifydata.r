library(readr)

original_data <- read_delim("~/Downloads/airbnb-listings.csv", delim = ";")

modified_data <- original_data[c("ID", "Listing Url", "Name", "City", "Country Code", "Country", "Latitude",
                                 "Longitude", "Minimum Nights", "Price", "Weekly Price", "Bedrooms", "Bathrooms"  ,"Beds", 
                                 "Bed Type", "Property Type", "Room Type", "Accommodates", "Guests Included", "Extra People", "Number of Reviews",
                                 "First Review","Last Review", "Review Scores Rating", "Review Scores Accuracy",
                                 "Review Scores Cleanliness", "Review Scores Checkin", "Review Scores Communication", "Review Scores Location",
                                 "Review Scores Value", "Picture Url")]

write.csv(modified_data, "~/Downloads/airbnb-covariate.csv")