# Load Libraries
library("dplyr")
library("ggplot2")


df <- read.csv("../data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

# violent chart of the price using number of bedrooms as factor
chart2 <- function(df) {
  price_by_bedrooms <- ggplot(df,  aes(x = bedrooms, y=price)) + 
    geom_violin(trim = FALSE, aes(fill = factor(bedrooms))) 
  return(price_by_bedrooms)
}