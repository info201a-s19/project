# Load Libraries
library("dplyr")
library("ggplot2")

# returns a violent chart of the price using number of bedrooms as factor
chart2 <- function(df) {
  # Format the price as numerical values
  df <- df %>%
    mutate(Price = as.numeric(gsub("[\\$,]", "", price)))

  price_by_bedrooms <- ggplot(df,  aes(x = bedrooms, y=Price)) +
    geom_violin(trim = FALSE,
                aes(fill = factor(bedrooms)),
                draw_quantiles = c(0.5)) +
    scale_fill_brewer(palette="Blues") +
    labs(title = "Price by Number of Bedromms", 
         x = "Number of Bedrooms", y = "Price per Night")
  return(price_by_bedrooms)
}
