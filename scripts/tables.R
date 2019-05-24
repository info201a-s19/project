library(dplyr)
library(knitr)

markdown_link <- function(string, link) {
  paste0("[", string, "](", link, ")")
}

markdown_image <- function(link, alt) {
  paste0("![", alt, "](", link, ")")
}

top_airbnb_table <- function(df) {
  df <- arrange(df, desc(review_scores_rating)) %>%
    head(20) %>%
    mutate(picture = markdown_image(picture_url,
                                    paste0(name, "'s picture"))) %>%
    mutate(name = markdown_link(name, listing_url)) %>%
    mutate(host = markdown_link(host_name, host_url)) %>%
    select(picture, name, room_type, host, street,
           review_scores_rating)
  kable(df, col.names = c("Picture", "Name", "Room Type", "Host",
                          "Location", "Review Score"))
}

summary_by_type_table <- function(df) {
  df <- df %>%
    group_by(room_type) %>%
    mutate(price = as.numeric(gsub("[$,]", "",
                                   price))) %>%
    mutate(cleaning_fee = ifelse(cleaning_fee == "", 0,
                                 as.numeric(gsub("[$,]", "",
                                                 cleaning_fee)))) %>%
    summarize(num = n(),
              rating = sprintf("%.2f",
                               mean(review_scores_rating, na.rm = TRUE)),
              num_reviews = sum(number_of_reviews),
              mean_price = sprintf("$%.2f", mean(price, na.rm = TRUE)),
              mean_clean_fee = sprintf("$%.2f",
                                       mean(cleaning_fee, na.rm = TRUE)),
              instant_bookable = sum(ifelse(instant_bookable == "t",
                                            1, 0))) %>%
    mutate(instant_bookable = sprintf("%.2f%%",
                                      instant_bookable / num * 100)) %>%
    arrange(desc(num))
  kable(df, col.names = c("Room Type", "Numbers Avaiable", "Mean Rating",
                          "Review Number", "Mean Price", "Mean Cleaning Fee",
                          "Instant Bookable Rate"))
}
