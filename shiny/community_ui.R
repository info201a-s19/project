library(shiny)
library(shinymaterial)

filter_sidebar <- sidebarPanel(
  titlePanel("Filter"),
  textInput(
    "name",
    label = "Name",
    value = "",
    placeholder = "Name"
  ),
  selectInput(
    "property_type",
    label = "Property Type",
    choices = property_types,
    selected = "All"
  ),
  selectInput(
    "room_type",
    label = "Room Type",
    choices = room_types,
    selected = "All"
  ),
  checkboxInput(
    "instant_book",
    label = "Instant Bookable",
    value = TRUE
  )
)

community_panel <- tabPanel(
  includeCSS("styles.css"),
  title = "Community Information",
  filter_sidebar,
  mainPanel(
    h3("Community Summary"),
    div(
      class = "card",
      textOutput("number"),
      p("Total Listing")
    ),
    plotOutput("bar-Chart")
  )
)
