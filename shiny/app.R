library(shiny)
airbnb <- read.csv("../data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)
source("map_server.R")
source("map_ui.R")

ui <- navbarPage(
  title = "Seattle Airbnbs Project",
  # Introductory page
  # Three interactive pages
  map_panel
  # Conclusion Page
)

server <- function(input, output, session) {
  map_server(input, output, session)
}

shinyApp(ui, server)