library(shiny)

page_one <- tabPanel(
  "Overview",
    mainPanel(
     tags$h1("Travel & Live in Seattle"),
     tags$h4("Karl Yang, Lin He, Peihuan Han, John Wang"),
     tags$h4("6/4/2019"),
     tags$img(src = "seattletravel.jpg", width = 600, height = 360),
     tags$p(strong("Seattle"), "is an exciting city.",
            strong("Delicious food"), "and", strong("beautiful seascapes"),
            "have attracted tourists from all around the world.",
            "A comfortable and convenient place to stay during vacation
            can enhance tourists experience. Airbnb accommodations are spreading
            around the world and it allows people to discover enticing places
            and feel at home at the same time."),
     tags$img(src = "airbnb.png", width = 600, height = 360),
     tags$p("Based on this, people coming to Seattle would like to choose
            high-cost performance Airbnb house instead of the traditional
            hotel.In this project, we will sort and analyze data collected
            by Airbnb in Seattle to help users explore popular neighborhoods
            based on their preference and find their best fit accommodations
            in Seattle."
       ),
     tags$img(src = "airbnb1.jpg", width = 600, height = 360),
     tags$p("The data was downloaded from ", a("Seattle Airbnb Open Data",
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

summary_page <- tabPanel(
  "Conclusion",
  fluidPage(
    h1("Major Take away")
  )
)

ui <- navbarPage(
  "Seattle Airbnb Project",
  page_one,
  page_five
)


server <- function(input, output) {
  
}

shinyApp(ui, server)
