# Ggplot horizontal bar chart module

# Echarts4r map module
import("shiny")
#import("plotly")
import("echarts4r")
import("ggplot2")
import("htmlwidgets")
import("dplyr")
import("tidytext")
import("textdata")
import("tm")
import("DT")
import("stringr")
import("utils")
export("ui")
import("reshape2")
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
  choices <- c("Positive words by Title","Positive words by Description","Negative words by Title","Negative words by Description")
  
  tagList(
    tags$div(
      class = "panel-header",
      selectInput(
        ns("metricclouds_positivenegative"), "Select Metric for Sentiments",
        choices,
        width = NULL,
        selectize = TRUE
      )
    ),
    
    br(),
    br(),
    echarts4rOutput(ns("wordclouds_pos_neg"))
    
  )
}

init_server <- function(id) {
  callModule(server, id)
}

server <- function(input, output, session) {
  
  
  dfsent <- reactive({
    
    if(str_detect(input$metricclouds_positivenegative,"Description")==TRUE){
      read.csv("data/sentiment_description.csv",header = T) %>% select(word,sentiment,n)
      
    }else{
      
      read.csv("data/sentiment_title.csv",header = T) %>% select(word,sentiment,n)
    }
    
    
    
  })
  
  dfsent_positive_negative <- reactive({
    
    if(str_detect(input$metricclouds_positivenegative,"Positive")==TRUE){
      dfsent() %>%
        filter(sentiment == "positive")
    }else{
      dfsent() %>%
        filter(sentiment == "negative")
    }
    
    
    
  })
  
  
  output$wordclouds_pos_neg <- renderEcharts4r({
    dfsent_positive_negative() |>
      arrange(desc(n))|>
      head(10) |>
      e_charts() |> 
      e_funnel(n, word) |>
      e_tooltip() |>
      e_theme("inspired")
    
  })
  
  
  
  
}