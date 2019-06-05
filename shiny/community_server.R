library(shiny)
library(dplyr)
library(ggplot2)

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