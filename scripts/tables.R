## Summary Table

# load necessary packages
library(dplyr)
library(knitr)

# convert links to markdown syntax
markdown_link <- function(string, link) {
  paste0("[", string, "](", link, ")")
}

markdown_image <- function(link, alt) {
  paste0("![", alt, "](", link, ")")
}

# generate a summary table that gives information about different airbnb
# room types
summary_by_type_table <- function(df) {
  df <- df %>%
    group_by(room_type) %>%
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
    summarize(
      num = n(),
      rating = sprintf(
        "%.2f",
        mean(review_scores_rating, na.rm = TRUE)
      ),
      num_reviews = sum(number_of_reviews),
      mean_price = sprintf("$%.2f", mean(price, na.rm = TRUE)),
      mean_clean_fee = sprintf(
        "$%.2f",
        mean(cleaning_fee, na.rm = TRUE)
      ),
      instant_bookable = sum(ifelse(instant_bookable == "t",
        1, 0
      ))
    ) %>%
    mutate(instant_bookable = sprintf(
      "%.2f%%",
      instant_bookable / num * 100
    )) %>%
    arrange(desc(num))
  kable(df, col.names = c(
    "Room Type", "Numbers Avaiable", "Mean Rating",
    "Review Number", "Mean Price", "Mean Cleaning Fee",
    "Instant Bookable Rate"
  ))
}
