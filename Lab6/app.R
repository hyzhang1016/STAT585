library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(ggvis)

nyc <- read.csv("nyc_emergency.csv", stringsAsFactors = FALSE)

shinyUI(fluidPage(

  titlePanel("NYC Crime Data"),

  sidebarPanel(
    selectInput("incident_type", "Incident Type", choices = sort(unique(nyc$Incident.Type)), selected = "Fire-3rd Alarm"),
    uiOutput("location_ui")
  ),

  mainPanel(
    ggvisOutput("locationggvis")
  )

))

shinyServer(function(input, output) {

  nyc_subset <- reactive({
    nyc %>%
      filter(Incident.Type == input$incident_type)
  })
  nyc_subset_loc %>% ggvis(x=~Latitude,y=~Longitude) %>% layer_points(fill:=input_select(label="Color of point",choices = c("pink","blue","green"),selected = "pink"),size:=input_slider(min=5,max=50)) %>% layer_model_predictions(model = input_radiobuttons(choices=c("Linear" = "lm", "LOESS" = "loess"))) %>% bind_shiny("locationggvis","location_ui")
})
