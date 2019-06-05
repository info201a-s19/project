# Load libraries so they are available
library("shiny")
library("ggplot2")
library("dplyr")

# Load data
airbnb <- read.csv("data/seattle-airbnb/listings.csv", stringsAsFactors = FALSE)

# Use source() to execute the `app_ui.R` and `app_server.R` files
source("app_ui.R")
source("app_server.R")

# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui = ui, server = server)
