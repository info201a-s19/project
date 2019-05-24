## Summary information 

#install.packages("stringr")
#install.packages("dplyr")
library("stringr")
library("dplyr")
library("knitr")

airbnb_info <- read.csv("data/seattle-airbnb/listings.csv",
                        stringsAsFactors = F)

summary_info <- function(df) {
  # remove $ signs for both price and cleaning fee value
  df <- df %>%
    mutate(price = as.numeric(gsub("[$,]", "",
                                   price))) %>%
    mutate(cleaning_fee = ifelse(cleaning_fee == "", 0,
                                 as.numeric(gsub("[$,]", "",
                                                 cleaning_fee)))) %>%
    select(name, price, cleaning_fee, minimum_nights, maximum_nights,
           reviews_per_month)
  
  # calculate average price and average cleaning fee and three more values
  avg_price <- round(mean(df$price, na.rm = T), 2)
  avg_cleaning_fee <- round(mean(df$cleaning_fee, na.rm = T), 2)
  most_review <- df %>%
    filter(reviews_per_month == max(reviews_per_month, na.rm = T)) %>%
    select(reviews_per_month) %>%
    pull()
  most_reviewed_house <- df %>%
      filter(reviews_per_month == max(reviews_per_month, na.rm = T)) %>%
        select(name) %>%
        pull()
  avg_min_night <- round(mean(df$minimum_nights, na.rm = T), 0)
  avg_max_night <- round(mean(df$maximum_nights, na.rm = T), 0)
  
  # print out a paragraph with those values in.
  paragraph <- paste0("Based on the data collected by Airbnb in 2016 ",
                      "the average price of Airbnb accommodations ",
                      "in seattle is ",
                      avg_price,
                      "$, and the average cleanning fee charged is ",
                      avg_cleaning_fee,
                      "$. The average minimum staying nights for ",
                      "living in Airbnb accomodations is ",
                      avg_min_night,
                      " nights, and the maximum staying nights ",
                      "for living in Airbnb accomodations is ",
                      avg_max_night,
                      " nights. In 2016, among all the Airbnb accommodations ",
                      "in seattle, ",
                      most_reviewed_house,
                      " is the most popular house with most review ",
                      most_review,
                      " per month among others."
                      )
  return(paragraph)
}
