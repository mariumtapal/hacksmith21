library(shiny)
library(reactable)
library(leaflet)
library(leaflet)
library(readxl)
library(janitor)
library(tidyverse)
library(readtext)
library(reactable)
library(plotly)

source("plots.R")

ui <- fluidPage(
  titlePanel("Massachusetts COVID-19 Vaccine Dashboard"),
  p("This dashboard was designed to help users locate vaccine locations in Massachusetts", style = "font-family: 'times'; font-si16pt"),
  strong("Find your nearest location and data about your state!"),
  em("This website is currently being developed."),
  br(),
  mainPanel(
    titlePanel("Proportion of people vaccinated in MA by age"),
    reactableOutput("table"),
    titlePanel("Vaccination Locations"),
    leafletOutput("mymap"),
    p(),
    strong("data from mass.gov"),
    p(),
  ),
  sidebarPanel(
    strong("Race/Ethnicity"),
    titlePanel("Population in MA vaccinated"),
    plotlyOutput("plot"),
    p()
  )
)



# reactable
server <- function(input, output) {
  output$table <- renderReactable({table
  })
  
  output$plot <- renderPlotly({
    plotly
  })
  
  # map
  output$mymap <- renderLeaflet({
    leaflet
  })
}

shinyApp(ui, server)