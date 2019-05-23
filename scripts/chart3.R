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
    df$average_rating <- round(df$average_rating, digits = 1)
    
    neighbourhood_chart <- ggplot(df, 
      mapping = aes(
        x = reorder(neighbourhood, average_rating), 
        y = average_rating)) +
      coord_flip() +
      ylim(c(90, 100)) +
      geom_text(aes(label = average_rating), hjust = 1, color = "white", size = 4) +
      labs(title = "Best Rating Neighbourhoods", x = "Neighbourhood", y = "Average Rating")
    
    return(neighbourhood_chart)
  }
  
  chart3(df)