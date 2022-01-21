# Echarts4r map module
import("shiny")
import("echarts4r")
import("htmlwidgets")
import("dplyr")
import("tidytext")
import("textdata")
import("tm")
import("DT")
import("stringr")
import("utils")
export("ui")
export("init_server")
import("wordcloud")
expose("utilities/getMetricsChoices.R")
expose("utilities/getTimeFilterChoices.R")
expose("utilities/getDataByTimeRange.R")
expose("utilities/getPercentChangeSpan.R")

consts <- use("constants.R")

ui <- function(id) {
  ns <- NS(id)
  
  # select only those metrics that are available per country
  choices <- c("Wordcloud by title","Wordcloud by Description")
  
  tagList(
    tags$div(
      class = "panel-header",
      selectInput(
        ns("metricclouds"), "Select metric for the map",
        choices,
        width = NULL,
        selectize = TRUE
      )
    ),
    echarts4rOutput(ns("wordclouds")),
  )
}

init_server <- function(id, amzndf) {
  callModule(server, id, amzndf)
}

server <- function(input, output, session, amzndf) {
  
  
  df <- reactive({
    
    if(str_detect(input$metricclouds,"title") == TRUE){
        read.csv("data/title_words.csv") %>%
        select(word,freq) %>%
        filter(freq > 30)
    }
    else{
      read.csv("data/descriptionwords.csv") %>%
        select(word,freq) %>%
        filter(freq > 100)
    }
    
  })
  
  
  
  output$wordclouds <- renderEcharts4r({
    
    df() |>
      e_color_range(freq, color) |>
      e_charts() |>
      e_cloud(word, freq, color, shape = "star") |> 
      e_tooltip()|>
      e_theme("forest")
  })
  
  
  

}


