## Chart 1

# Load Libraries
library("dplyr")
library("ggplot2")
library("leaflet")

# Plot all the listing on a map and put some useful information
# in the popup window
chart1 <- function(df) {
  map <- leaflet(df) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -122.3321, lat = 47.6062, zoom = 11) %>%
    addCircles(
      lat = ~latitude,
      lng = ~longitude,
      popup = ~ paste(
        paste0("<b><img src=", thumbnail_url, ">"),
        name,
        paste0("Rating: ", review_scores_rating),
        paste0("<b><a href=", listing_url, ">Open in Airbnb</a></b>"),
        sep = "<br/>"
      ),
      radius = 30,
      fillOpacity = 0.5,
      stroke = FALSE
    )
  return(map)
}
