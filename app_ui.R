# Load necessary libraries
library("shiny")
library("dplyr")
library("ggplot2")

# Load data frame
airbnb <- read.csv("data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

# introduction page 
introduction <- tabPanel(
  "Overview",
  mainPanel(
    tags$h1("Choose your best Airbnb fit in Seattle"),
    tags$h4("Karl Yang, Lin He, Peihuan Han, John Wang"),
    tags$h4("6/4/2019"),
    tags$img("", src = "seattletravel.jpg", 
             width = 600, height = 360),
    tags$p(strong("Seattle"), "is an exciting city.",
           strong("Delicious food"), "and", strong("beautiful seascapes"),
           "have attracted tourists from all around the world.",
           "A comfortable and convenient place to stay during vacation
           can enhance tourists experience. Airbnb accommodations are spreading
           around the world and it allows people to discover enticing places
           and feel at home at the same time."),
    tags$img("", src = "airbnb.png", width = 600, height = 360),
    tags$p("Based on this, people coming to Seattle would like to choose
           high-cost performance Airbnb house instead of the traditional
           hotel.In this project, we will sort and analyze data collected
           by Airbnb in Seattle to help users explore popular neighborhoods
           based on their preference and find their best fit accommodations
           in Seattle."
    ),
    tags$img("", src = "airbnb1.jpg", width = 600, height = 360),
    tags$p("The data was downloaded from ",
           a("Seattle Airbnb Open Data",
             href = "https://www.kaggle.com/airbnb/seattle#listings.csv"), 
           "Seattle Airbnb Open Data was collected as part of the Airbnb
           Inside initiative.", "It described the listing activity of homestays
           in Seattle, WA."),
    tags$p("This Seattle dataset includes three parts, * Listings, including
           full descriptions and average review score * Reviews, including
           unique id for each reviewer and detailed comments * Calendar,
           including listing id and the price and availability for that day"),
    tags$h4("General Questions"),
    tags$p("where are the top 5 rated Airbnbs neigbourhood in Seattle?"),
    tags$p("which room type in Airbnb is most popular one in Seattle area"),
    tags$p("where are the area in seattle have more airbnb house than others")
    )
    )
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
  introduction,
  # First interactive page
  interactive_page_one,
  # Second interactive page
  interactive_page_two
  
  # Third interactive page
  
  # Conclusion
  
)
