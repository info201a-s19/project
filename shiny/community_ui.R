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

card_container <- div(
  id = "card-container",
  div(
    class = "card",
    textOutput("number"),
    p(id = "grey-font", "Total Listing")
  ),
  div(
    class = "card",
    textOutput("price"),
    p(id = "grey-font", "Average price")
  ),
  div(
    class = "card",
    textOutput("number"),
    p(id = "grey-font", "Average Rating")
  )
)

community_panel <- tabPanel(
  includeCSS("styles.css"),
  title = "Community Information",
  filter_sidebar,
  mainPanel(
    h3("Community Summary"),
    card_container,
    plotOutput("bar-Chart")
  )
)
