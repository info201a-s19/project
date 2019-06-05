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
    tags$img("",
      src = "seattletravel.jpg",
      width = 600, height = 360
    ),
    tags$p(
      strong("Seattle"), "is an exciting city.",
      strong("Delicious food"), "and", strong("beautiful seascapes"),
      "have attracted tourists from all around the world.",
      "A comfortable and convenient place to stay during vacation
           can enhance tourists experience. Airbnb accommodations are spreading
           around the world and it allows people to discover enticing places
           and feel at home at the same time."
    ),
    tags$img("", src = "airbnb.png", width = 600, height = 360),
    tags$p("Based on this, people coming to Seattle would like to choose
           high-cost performance Airbnb house instead of the traditional
           hotel. In this project, we will sort and analyze data collected
           by Airbnb in Seattle to help users explore popular neighborhoods
           based on their preference and find their best fit accommodations
           in Seattle."),
    tags$img("", src = "airbnb1.jpg", width = 600, height = 360),
    tags$p(
      "The data was downloaded from ",
      a("Seattle Airbnb Open Data",
        href = "https://www.kaggle.com/airbnb/seattle#listings.csv"
      ),
      "Seattle Airbnb Open Data was collected as part of the Airbnb
           Inside initiative.", "It described the listing activity of homestays
           in Seattle, WA."
    ),
    tags$p("This Seattle dataset includes three parts: Listings, including
           full descriptions and average review score, Reviews, including
           unique id for each reviewer and detailed comments, Calendar,
           including listing id and the price and availability for that day."),
    tags$h4("General Questions"),
    tags$p("where are the most popular and most expensive
           neigbourhood in Seattle?"),
    tags$p("which room type in Airbnb is most popular in Seattle area?"),
    tags$p("How does the price change as the number of bedroom or bathroom
           increasing?")
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
  "Trends and Patterns",
  titlePanel("Trends and Patterns"),

  # Description
  p("Interesting in some useful trends and patterns about the Airbnb data?
    The purpose of this page is to reveal the relationships
    between different variables from the Airbnb data so that the users
    can quickly find choices of Airbnbs that best fit their needs.
    For example, if there are 4 people looking
    for an Airbnb with relatively low price and they wonder how many
    of this type of Airbnb are available in the market
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
        choices = c(
          "Accommodates", "Bathrooms",
          "Bedrooms", "Beds"
        )
      ),
      # Second input
      gains <- selectInput(
        "y_var",
        label = "Gains",
        choices = c(
          "Price", "Reviews", "Rating",
          "ReviewsPerMonth"
        )
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

# Third page
neighbourhood_list <- airbnb %>%
  select(neighbourhood) %>%
  unique() %>%
  filter(nchar(neighbourhood) > 0) %>%
  pull()
# Add `All = ""` at front
neighbourhood_list <- list("neighbourhood_list" = c("All", neighbourhood_list))

summary_cards <- div(
  id = "card-container",
  div(
    class = "card",
    h4(textOutput("number")),
    p("Number of Listing", class = "grey-font")
  ),
  div(
    class = "card",
    h4(textOutput("price")),
    p("Average Price", class = "grey-font")
  ),
  div(
    class = "card",
    h4(textOutput("rating")),
    p("Average Rating", class = "grey-font")
  )
)

interactive_page_three <- tabPanel(
  "Neighbourhood Info",
  titlePanel("Neighbourhood Info"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "neighbourhood",
        label = "neighbourhood",
        choices = neighbourhood_list,
        selected = "All"
      )
    ),
    mainPanel(
      h3("Key Index"),
      summary_cards,
      plotOutput("barchart"),
      p("You can find out the summary information of the neighbourhood
        you are planning to stay. The pricing, rating, and avaibility
        are the infomation that most visitors care about. You can know
        more the communities in Seattle as you navigate different
        neigbourhoods.")
    )
  )
)
summary <- tabPanel(
  "Conclusion",
  mainPanel(
    tags$h1("Takeaways from project"),
    tags$h3("1. Distribution of Airbnb House"),
    p(
      "From the first interactive map, we can get a good sense of Airbnb
      distribution in Seattle. Apartment and House are two major Airbnb
      property type. A lot of listings are clustered in downtown
      Seattle. It is reasonable because downtown seattle cosist many fanous
      restarount and tourist attractions such as", em("Pike Market"),
      "It will be convenience for visitors to live in downtown seattle.
      Capital hill and university district are also popular places to live
      since one has many delicious food and one located near University so
      parents or other visitors who wants to visit the University will
      want to live there."
    ),
    tags$img("",
      src = "distribution.png",
      widisdth = 600, height = 360
    ),
    p("In the broader view, the host could buy the house near attractions of
      the city and the visitors can also choose thoes palce to live while
      traveling. Therefore, the land will be more expensive for thoes area"),

    h3("2. Price change Factors"),
    p("The second plot shows how price changes according to the change in
      numbers of Bedroom and numbers of people live in. According to the graph,
      price increases most along with the increasing number of Bedrooms."),
    tags$img("",
      src = "bedroom.png",
      widisdth = 600, height = 360
    ),
    p("The price will not vary much when the numbers of lodger is less than
      4 people or the numbers of bathroom is less than 2. There is a large
      price shift when more than 8 people can live in and more than 4 bedrooms
      , 3 bathrooms in the house."),
    tags$img("",
      src = "accommodate.png",
      widisdth = 600, height = 360
    ),

    p("To conclude, if the lodgers are less than 2 people, living in hotel might
      be a better choice, if they have more than 3 people, Airbnb will provide
      a high cost performance."),

    h3("3. Room type"),
    p(
      "Refer to our third plot, there are 2818 listing Airbnb houses in Seattle
      in 2016. The plot shows the number of listing and average Price for
      different neighbourhood. Overall, The average price for Airbnb in Seattle
      is 128$. There are three types of room choice on Airbnb:",
      strong("Entire home/apt, Private room, and Shared room"),
      "there are 2541", em("Entire home/apt"), "1160", em("Private room"),
      "and only 117", em("Shared room"), "listed on Airbnb."
    ),
    p("Within Seattle Area, Industrial District, Fairmount Park, Alki,
      Pioneer Square, Magnolia, Portage Bay are the enighbourhood that has
      high average price from 150$ to 300$ per night. They all have a common
      feature, located near the seascape or far from the busy city area. This
      is not hard to understand, the price will rise as the views from the
      house gets better."),
    p("From this we can conclude that the sea-view house will be more expensive
      than others, it will be more suitable for people who are rich and have
      cars and have longer vacations.")
  )
)
# Pass the user interface page to a multi-page layout
ui <- navbarPage(
  includeCSS("styles.css"),
  id = "Seattle Airbnbs Project",
  # Introduction
  introduction,
  # First interactive page
  interactive_page_one,
  # Second interactive page
  interactive_page_two,
  # Third interactive page
  interactive_page_three,
  # Conclusion
  summary
)
