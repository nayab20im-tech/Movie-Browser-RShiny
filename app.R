# Install required packages if not already installed
# install.packages(c("shiny", "ggplot2", "dplyr"))

library(shiny)
library(ggplot2)
library(dplyr)

# Load the dataset
movies <- read.csv("movies.csv")

# UI ----
ui <- fluidPage(
  titlePanel("Movie Browser, 1970 - 2014"),
  sidebarLayout(
    sidebarPanel(
      h3("Plotting"),
      selectInput("xvar", "X-axis:", choices = names(movies), selected = "CriticsScore"),
      selectInput("yvar", "Y-axis:", choices = names(movies), selected = "AudienceScore"),
      selectInput("colorvar", "Color by:", choices = names(movies), selected = "MPAA.Rating"),
      sliderInput("alpha", "Alpha:", min = 0, max = 1, value = 0.5, step = 0.1),
      sliderInput("size", "Size:", min = 1, max = 5, value = 3)
    ),
    mainPanel(
      plotOutput("scatterPlot")
    )
  )
)

# Server ----
server <- function(input, output) {
  output$scatterPlot <- renderPlot({
    ggplot(movies, aes_string(x = input$xvar, y = input$yvar, color = input$colorvar)) +
      geom_point(alpha = input$alpha, size = input$size) +
      theme_minimal() +
      labs(x = input$xvar, y = input$yvar, color = input$colorvar)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
