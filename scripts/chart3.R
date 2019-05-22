# Load Libraries
library("dplyr")
library("ggplot2")


df <- read.csv("../data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

chart3 <- function(df) {
  # Summerise the rating by neighbourhood
  df <- df %>% 
    group_by(neighbourhood) %>% 
    # rating empty
    summarise(average_rating = mean(review_scores_rating, na.rm=TRUE)) %>% 
    arrange(-average_rating) %>% 
    head(10)
  
  neighbourhood_chart <- ggplot(df, mapping = aes(x = neighbourhood, y = average_rating)) +
    geom_col() +
    coord_flip() +
    labs(title = "Best Rating Neighbourhoods", x = "Neighbourhood", y = "Average Rating")
  
  return(neighbourhood_chart)
}

chart3(airbnb)