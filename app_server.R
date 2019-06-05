# Load necessary libraries
library("ggplot2")
library("shiny")
library("dplyr")
library("plotly")

# Create a server function that takes in user's input and return output
server <- function(input, output) {
  # Return output
  # Output for introduction

  # Output for first interactive page
  output$map <- renderLeaflet({
    # Make map
    make_map <- function(df) {
      map <- leaflet(df) %>%
        addProviderTiles("CartoDB.Positron") %>%
        setView(lng = -122.3321, lat = 47.6062, zoom = 11) %>%
        addCircles(
          lat = ~latitude,
          lng = ~ longitude,
          popup = ~ paste(
            paste0("<b><img src=", thumbnail_url, ">"),
            name,
            paste0("Rating: ", review_scores_rating),
            paste0("<b><a href=", listing_url, ">Open in Airbnb</a></b>"),
            sep = "<br/>"
          ),
          radius = 30,
          fillOpacity = 0.5,
          stroke = FALSE
        )
      return(map)
    }

    data <- airbnb %>%
      filter(grepl(input$name, name)) %>%
      filter(input$instant_book == (instant_bookable == "t"))
    if (input$property_type != "All") {
      data <- filter(data, property_type == input$property_type)
    }
    if (input$room_type != "All") {
      data <- filter(data, room_type == input$room_type)
    }
    make_map(data)
  })
  # Output for second interactive page
  output$useful_correlations <- renderPlotly({
    # Store the title
    title <- paste(
      "Correlation Between", input$x_var, "and", input$y_var
    )

    # Reorganize the data
    data_needed <- airbnb %>%
      select(accommodates, bathrooms, bedrooms, beds, price,
             number_of_reviews, review_scores_rating, reviews_per_month)

    colnames(data_needed) <- c(
      "Number_of_Accommodates", "Number_of_Bathrooms",
      "Number_of_Bedrooms", "Number_of_Beds",
      "Price", "Number_of_Reviews", "Rating",
      "Reviews_per_Month"
    )

    data_needed <- data_needed %>%
      mutate(Price = as.numeric(gsub("[\\$,]", "", Price)))

    # Create a scatter plot that reveals the correlation
    scatter_plot <- ggplot(data = data_needed) +
      geom_point(
        mapping = aes_string(x = input$x_var, y = input$y_var),
        size = input$size
      ) +
      labs(
        x = input$x_var,
        y = input$y_var,
        title = title
      )

    # return the scatter plot
    scatter_plot
  })

  # Output for third interactive page
  output$barchart <- renderPlot({
    if (input$neighbourhood != "All") {
      airbnb <- airbnb %>%
        filter(neighbourhood == input$neighbourhood)
    }
    data <- airbnb %>%
      group_by(room_type) %>%
      summarise(n = n())
    # Bar chart doesn't have hover over function
    chart <- ggplot(data, aes(x = reorder(room_type, n),
                              y = n, fill = room_type)) +
      geom_col() +
      coord_flip() +
      scale_fill_brewer(palette = "Set1") +
      labs(
        title = "Room Distribution",
        x = "Room Type",
        y = "Number of Room"
      )
    return(chart)
  })

  output$number <- renderText({
    if (input$neighbourhood != "All") {
      airbnb <- airbnb %>%
        filter(neighbourhood == input$neighbourhood)
    }
    return(nrow(airbnb))
  })

  output$price <- renderText({
    if (input$neighbourhood != "All") {
      airbnb <- airbnb %>%
        filter(neighbourhood == input$neighbourhood)
    }
    data <- airbnb %>%
      mutate(Price = as.numeric(gsub("[\\$,]", "", price)))
    average_price <- data %>%
      summarise(average_price = mean(Price, na.rm = TRUE)) %>%
      pull(average_price)
    return(round(average_price))
  })

  output$rating <- renderText({
    if (input$neighbourhood != "All") {
      airbnb <- airbnb %>%
        filter(neighbourhood == input$neighbourhood)
    }
    average_rating <- airbnb %>%
      summarise(average_rating = mean(review_scores_rating, na.rm = TRUE)) %>%
      pull(average_rating)
    return(round(average_rating))
  })
  # Output for conclusion
}
