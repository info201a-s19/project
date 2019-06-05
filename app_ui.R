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
  
  titlePanel("Airbnb Map in Seattle"),
  
  p("In this page you can get a good sense of the geographical distributon 
    of the Airbnb listings in Seattle. A lot of listings are clustered 
    in downtown seattle. You may find a lot of choice over there. 
    You can click on the listing if you want to find more information. 
    The popup window will provides you a thrumbnail image of the listing along 
    with other useful information. If you want to find out more about the 
    listing, you can click on the link which will bring you to Airbnb!   
    You could also search for a specfic room by its name, filter by its  
    property type or room type, and weather its instant bookable."),
  
  sidebarPanel(
    titlePanel("Filter"),
    textInput(
      "name",
      label = "Airbnb Name",
      value = "",
      placeholder = "Search"
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
  "Useful Correlations Between the Offers and the Gains for Airbnb Hosts",
  titlePanel("Useful Correlations Between the Offers and the Gains for Airbnb Hosts"),
  
  # Description
  p("The purpose of this page is to give Airbnb hosts some general ideas about
    the relationship between what they offer to the customers and what they can
    receive from the customers. For example, if the Airbnb can accommodate
    4 people and the Airbnb host wonders how much he/she should set the price
    of the Airbnb to be, the Airbnb host can refer to the 
    Number_of_Accommodates VS Price plot"),
  
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