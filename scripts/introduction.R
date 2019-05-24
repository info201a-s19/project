## Summary information 

install.packages("stringr")
install.packages("dplyr")
library("stringr")
library("dplyr")
library("knitr")

airbnb_info <- read.csv("data/seattle-airbnb/listings.csv",
                        stringsAsFactors = F)

#markdown_value <- function()

summary_info <- function(df, col_name) {
  df <- df %>%
    mutate(price = as.numeric(gsub("[$,]", "",
                                   price))) %>%
    mutate(cleaning_fee = ifelse(cleaning_fee == "", 0,
                                 as.numeric(gsub("[$,]", "",
                                                 cleaning_fee)))) %>%
    select(name, price, cleaning_fee, minimum_nights, maximum_nights)
  if (col_name == "price" | col_name == "cleaning_fee"){
    info <- mean(df[[col_name]], na.rm = T)
  } else if (col_name == "reviews_per_month"){
    info <- df %>%
      filter(df[[col_name]] == max(df[[col_name]], na.rm = T)) %>%
      pull(name)
  } else if (col_name == "minimum_nights"){
    info <- mean(df[[col_name]], na.rm = T)
  } else if (col_name == "maximum_nights"){
    info <- mean(df[[col_name]], na.rm = T)
  }
  info
}

