library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)
library(stringr)

# Load Data
airbnb <- read.csv("../data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

# Plot all the listing on a map and put some useful information 
# in the popup window 

make_map <- function(df) {
  map <- leaflet(df) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -122.3321, lat = 47.6062, zoom = 11) %>%
    addCircles(
      lat = ~latitude,
      lng = ~ longitude,
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

map_server <- function(input, output, session) {
  output$map <- renderLeaflet({
    data <- airbnb %>%
      filter(grepl(input$name, name)) %>%
      filter(input$instant_book == (instant_bookable == "t"))
    if (input$property_type != "All") {
      data <- filter(data, property_type == input$property_type)
    }
    if (input$room_type != "All") {
      data <- filter(data, room_type == input$room_type)
    }
    make_map(data)
  })
}