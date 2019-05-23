# Load Libraries
library("dplyr")
library("ggplot2")
library("leaflet")

df <- read.csv("../data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

chart1 <- function(df) {
  # Select the columns of interest
  df <- df %>% 
    select(latitude, longitude, name, review_scores_rating, listing_url)
  
  map <- leaflet(df) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -122.3321, lat = 47.6062, zoom = 10) %>% 
    addCircles(
      # null data ??? Bug
      lat = ~latitude, 
      lng = ~ longitude,
      popup = ~ paste(
        paste0("Name: ", name),
        paste0("Rating: ", review_scores_rating),
        paste0("[Open in Airbnb](", listing_url, ")"),
        sep="<br/>"
        ),
      radius = 20,
      fillOpacity = 0.5,
      stroke = FALSE
    )
  map
}

map <- chart1(df)