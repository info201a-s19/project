# Load Libraries
library("dplyr")
library("ggplot2")


df <- read.csv("../data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

# violent chart of the price using number of bedrooms as factor
chart2 <- function(df) {
  df <- df %>% 
    mutate(Price = as.numeric(gsub("[\\$,]", "", price)))
  
  price_by_bedrooms <- ggplot(df,  aes(x = bedrooms, y=Price)) + 
    geom_violin(trim = FALSE, 
                aes(fill = factor(bedrooms)), 
                draw_quantiles = c(0.5))
  return(price_by_bedrooms)
}

chart2(df)