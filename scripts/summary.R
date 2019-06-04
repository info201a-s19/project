## Summary information

# load necessary packages
library("stringr")
library("dplyr")
library("knitr")

airbnb_info <- read.csv("data/seattle-airbnb/listings.csv",
  stringsAsFactors = F
)

# generate a function that takes in a data frame and
# returns a list of relevant variables
summary_info <- function(df) {
  # remove $ signs for both price and cleaning fee value
  df <- df %>%
    mutate(price = as.numeric(gsub(
      "[$,]", "",
      price
    ))) %>%
    mutate(cleaning_fee = ifelse(cleaning_fee == "", 0,
      as.numeric(gsub(
        "[$,]", "",
        cleaning_fee
      ))
    )) %>%
    select(
      name, price, cleaning_fee, minimum_nights, maximum_nights,
      reviews_per_month
    )

  # calculate average price and average cleaning fee and three more values
  variables <- list(
    avg_price = round(mean(df$price, na.rm = T), 2),
    avg_cleaning_fee = round(mean(df$cleaning_fee, na.rm = T), 2),
    most_review = df %>%
      filter(reviews_per_month == max(reviews_per_month, na.rm = T)) %>%
      select(reviews_per_month) %>%
      pull(),
    most_reviewed_house = df %>%
      filter(reviews_per_month == max(reviews_per_month, na.rm = T)) %>%
      select(name) %>%
      pull(),
    avg_min_night = round(mean(df$minimum_nights, na.rm = T), 0),
    avg_max_night = round(mean(df$maximum_nights, na.rm = T), 0)
  )
  return(variables)
}
