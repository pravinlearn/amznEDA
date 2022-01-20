# Ggplot horizontal bar chart module

# Echarts4r map module
import("shiny")
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
  choices <- c("Sentiment by Title","Sentiment by Description")
  
  tagList(
    tags$div(
      class = "panel-header",
      selectInput(
        ns("metricclouds_positivenegative"), "Select metric for the map",
        choices,
        width = NULL,
        selectize = TRUE
      )
    ),
    
    br(),
    br(),
      plotOutput(ns("wordclouds_pos_neg"))
    
  )
}

init_server <- function(id) {
  callModule(server, id)
}

server <- function(input, output, session) {
  
  
  dfsent <- reactive({
    
    if(str_detect(input$metricclouds_positivenegative,"Description")==TRUE){
      read.csv("data/sentiment_description.csv") %>% select(X,sentiment,n)
      
    }else{
      
      read.csv("data/sentiment_title.csv") %>% select(X,sentiment,n)
    }
   
     
    
  })
  
  
  
  output$wordclouds_pos_neg <- renderPlot({
    dfsent() %>%
      group_by(sentiment) %>%
      slice_max(n, n = 10) %>% 
      ungroup() %>%
     # mutate(word = reorder(word, n)) %>%
      ggplot(aes(n, word, fill = sentiment)) +
      geom_col(show.legend = FALSE) +
      facet_wrap(~sentiment, scales = "free_y") +
      labs(x = "Contribution to sentiment",
           y = NULL) 
  })
  
  
  
  
}