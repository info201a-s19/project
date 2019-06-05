library(shiny)
source("map_server.R")
source("map_ui.R")
source("community_ui.R")
source("community_server.R")
# Load Data
airbnb <- read.csv("../data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

ui <- navbarPage(
  title = "Seattle Airbnbs Project",
  # Introductory page
  # Three interactive pages
  map_panel,
  community_panel
  # Conclusion Page
)

server <- function(input, output, session) {
  map_server(input, output, session)
}

shinyApp(ui, server)