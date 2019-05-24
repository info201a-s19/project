## Chart 3

# Load Libraries
library("dplyr")
library("ggplot2")

# Returns a bar chart of the top five best rating neighbourhoods
chart3 <- function(df) {
  # Summerise the rating by neighbourhood
  df <- df %>%
    group_by(neighbourhood) %>%
    summarise(average_rating = mean(review_scores_rating, na.rm = TRUE)) %>%
    arrange(-average_rating) %>%
    head(5)
  # Round the rating
  df$average_rating <- round(df$average_rating, digits = 1)

  neighbourhood_chart <- ggplot(df,
    mapping = aes(
      x = reorder(neighbourhood, average_rating),
      y = average_rating
    )
  ) +
    geom_col(fill = "#0B6AB0") +
    coord_flip() +
    geom_text(aes(label = average_rating),
      hjust = 1.4, color = "white",
      size = 5
    ) +
    labs(
      title = "Best Rating Neighbourhoods", x = "Neighbourhood",
      y = "Average Rating"
    )

  return(neighbourhood_chart)
}
