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

data <- read_xlsx("data.xlsx", skip = 1) %>% clean_names()
map <- read_csv("mapDataFR.txt")
vaccines_am <- read_xlsx("covid19report.xlsx", sheet = "Age - municipality", skip = 1)
vaccines_rem <- read_xlsx("covid19report.xlsx", sheet = "Race and ethnicity - muni.", skip = 1)

vaccines_am2 <- vaccines_am %>%
  filter(`Age Group` != "Total") %>%
  filter(`Fully vaccinated individuals` != "*" | `Proportion of town fully vaccinated individuals` != "*") %>%
  filter(County != "Unspecified") %>%
  mutate(
    `Fully vaccinated individuals` = as.numeric(`Fully vaccinated individuals`),
    `Proportion of town fully vaccinated individuals` = as.numeric(`Proportion of town fully vaccinated individuals`)
  ) %>%
  select(c(County, Town, `Age Group`, Population, `Fully vaccinated individuals`, `Proportion of town fully vaccinated individuals`))
vaccines_am2$Population <- round(vaccines_am2$Population, 0)
vaccines_am2$`Proportion of town fully vaccinated individuals` <- round(vaccines_am2$`Proportion of town fully vaccinated individuals`, 3)
vaccines_am2 <- vaccines_am2[, c(2, 1, 3, 4, 5, 6)]


# vaccine by race/ethnicity
vaccines_rem2 <- vaccines_rem %>%
  filter(`Race/Ethnicity` != "Total") %>%
  filter(`Fully vaccinated individuals` != "*" | `Proportion of town fully vaccinated individuals` != "*") %>%
  mutate(
    `Fully vaccinated individuals` = as.numeric(`Fully vaccinated individuals`),
    `Proportion of town population` = as.numeric(`Proportion of town population`),
    `Proportion of town fully vaccinated individuals` = as.numeric(`Proportion of town fully vaccinated individuals`)
  ) %>%
  select(c(`Race/Ethnicity`, Population, `Fully vaccinated individuals`))
newdata <- vaccines_rem2 %>% group_by(`Race/Ethnicity`) %>% 
  summarise(across(everything(), sum)) %>% 
  mutate(Proportion = `Fully vaccinated individuals`/Population) %>% 
  filter(Proportion != Inf)



ui <- fluidPage(
  titlePanel("Massachusetts COVID-19 Vaccine Dashboard"),
  p("This dashboard was designed to help users locate vaccine locations in Massachusetts", style = "font-family: 'times'; font-si16pt"),
  mainPanel(
    titlePanel("Proportion of people vaccinated in MA by age"),
    reactableOutput("table"),
    titlePanel("Vaccination Locations"),
    leafletOutput("mymap"),
    p()
  ),
  sidebarPanel(
    titlePanel("Population in MA vaccinated"),
    plotlyOutput("plot"),
    p()
    
  )
  
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
  
  output$plot <- renderPlotly({
    ggplotly(ggplot(newdata, 
                    aes(x = `Race/Ethnicity`, y = Proportion, fill = `Race/Ethnicity`)) + geom_col())
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