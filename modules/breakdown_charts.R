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
  choices <- c("Wordcloud by title","Wordcloud by Description","Sentiment by Title","Sentiment by Description")
  
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
    plotOutput(ns("wordclouds")),
  )
}

init_server <- function(id, amzndf) {
  callModule(server, id, amzndf)
}

server <- function(input, output, session, amzndf) {
  
  
  df <- reactive({
    read.csv("data/descriptionwords.csv") %>%
      select(word,freq) %>%
      filter(freq > 100)
    
  })
  
  
  
  output$wordclouds <- renderPlot({
    
    wordcloud(words = df()$word, 
              freq = df()$freq, 
              random.order=FALSE, rot.per=0.3,   
              scale=c(4,.5))
  })
  
  
  

}


