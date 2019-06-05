library(shiny)

property_types <- airbnb %>%
  select(property_type) %>%
  unique() %>%
  filter(nchar(property_type) > 0) %>%
  pull()
# Add `All = ""` at front
property_types <- list("property_types" = c("All", property_types))

room_types <- airbnb %>%
  select(room_type) %>%
  unique() %>%
  filter(nchar(room_type) > 0)
# Add `all` at front
room_types <- list("room_types" = c("All", room_types))

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

map_panel <- tabPanel(
  title = "Airbnb Map in Seattle",
  filter_sidebar,
  mainPanel(
    leafletOutput("map")
  )
)