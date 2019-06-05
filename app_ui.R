# Load necessary libraries
library("shiny")

# Load data frame
airbnb <- read.csv("data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

# Define the user interface content
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
  
  # Second interactive page
  interactive_page_two
  
  # Third interactive page
  
  # Conclusion
  
)