# Load necessary libraries
library("shiny")
library("dplyr")
library("ggplot2")

# Load data frame
airbnb <- read.csv("data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

# Define the user interface content

# First page
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

interactive_page_one <- tabPanel(
  title = "Airbnb Map in Seattle",
  
  sidebarPanel(
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
  ),
  mainPanel(
    leafletOutput("map")
  )
)

# Second page
interactive_page_two <- tabPanel(
  "Useful Correlations Between the Offers and the Gains",
  titlePanel("Useful Correlations Between the Offers and the Gains"),
  
  # Description
  p("The purpose of this page is to give people some general ideas about
    the relationship between what they offer and what they can
    receive from the Airbnbs. For example, if there are 4 people looking 
    for an Airbnb and the customers wonder how much they should be charged
    , they can refer to the Number_of_Accommodate VS Price plot. 
    If the customers want an Airbnb with two bedrooms, they can refer to 
    the Number_of_Bedrooms VS Rating plot in order to get a sense of whether 
    there are plenty of good rated Airbnbs for them to choose from"),
  
  # This content uses a sidebar layout
  sidebarLayout(
    # Create the widgets
    sidebarPanel(
      # First input
      offers <- selectInput(
        "x_var",
        label = "Offers",
        choices = c("Number_of_Accommodates", "Number_of_Bathrooms",
                    "Number_of_Bedrooms", "Number_of_Beds")
      ),
      # Second input
      gains <- selectInput(
        "y_var",
        label = "Gains",
        choices = c("Price", "Number_of_Reviews", "Rating",
                    "Reviews_per_Month")
      ),
      # Size of the dot input
      size_input <- sliderInput(
        "size",
        label = "Size of the dot",
        min = 1,
        max = 10,
        value = 3
      )  
    ),
    # Create the plot
    mainPanel(
        plotOutput("useful_correlations")
    )
  )
)

# Pass the user interface page to a multi-page layout
ui <- navbarPage(
  "Seattle Airbnbs Project",
  # Introduction
  
  # First interactive page
  interactive_page_one,
  # Second interactive page
  interactive_page_two
  
  # Third interactive page
  
  # Conclusion
  
)