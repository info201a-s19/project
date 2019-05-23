library(dplyr)
library(knitr)

airbnb_listing <- read.csv("data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

markdown_link <- function(string, link) {
  paste0("[", string, "](", link,")")
}

markdown_image <- function(link, alt) {
  paste0("![", alt, "](", link,")")
}

top_airbnb_table <- function(df) {
  df <- arrange(airbnb_listing, desc(review_scores_rating)) %>%
    slice(1:20) %>%
    mutate(picture = markdown_image(picture_url, paste0(name, "'s picture"))) %>%
    mutate(name = markdown_link(name, listing_url)) %>%
    mutate(host = markdown_link(host_name, host_url)) %>%
    select(picture, name, room_type, host, street, review_scores_rating)
  kable(df, col.names = c("Picture", "Name", "Room Type", "Host", "Location", "Review Score"))
}
