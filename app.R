library(shiny)
library(reactable)
library(leaflet)

ui <- fluidPage(
  titlePanel("Massachusetts COVID-19 Vaccine Dashboard"),
  reactableOutput("table"),leafletOutput("mymap"),
  p()
)
# reactable
server <- function(input, output) {
  output$table <- renderReactable({
    reactable(vaccines_am2, searchable = TRUE, filterable = TRUE, theme = reactableTheme(
      borderColor = "#dfe2e5",
      stripedColor = "#f6f8fa",
      highlightColor = "#f0f5f9",
      cellPadding = "8px 12px",
      style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif"),
      searchInputStyle = list(width = "100%")
    ))
  })
  
# map
  
  output$mymap <- renderLeaflet({
    map %>%
      leaflet() %>%
      addTiles() %>%
      addTiles(group = "Open Street Maps") %>%
      addCircleMarkers(
        data = map, radius = 5,
        color = "purple",
        popup = map$name
      ) %>%
      setView(lng = -71.47275, lat = 42.24943, zoom = 7)
  })
}

shinyApp(ui, server)
