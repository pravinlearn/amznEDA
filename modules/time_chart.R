# Dygraphs vertical bar chart module

import("shiny")
import("dygraphs")
import("glue")
import("tidyselect")
import("lubridate")
import("xts")
import("utils")
import("dplyr")
import("echarts4r")
export("ui")
export("init_server")
import("stringr")
expose("utilities/getMetricsChoices.R")
expose("utilities/getTimeFilterChoices.R")
expose("utilities/getDataByTimeRange.R")
expose("utilities/getPercentChangeSpan.R")

consts <- use("constants.R")

ui <- function(id) {
  ns <- NS(id)
  
  # Add all available metrics to dygraph chart
  choices <- c("Top 5 contries with highest content","Least 5 contries with low contents")
  
  tagList(
    tags$div(
      class = "panel-header",
      selectInput(
        ns("metric"), "Select metric for the time chart",
        choices,
        width = NULL,
        selectize = TRUE,
      )
    ),
    tags$div(
      class = "chart-time-container",
      echarts4rOutput(ns("plotdonut"))
      
    )
  )
}

init_server <- function(id, amzndfs) {
  callModule(server, id, amzndfs)
}

server <- function(input, output, session, amzndfs) {
  
  
  
  content_with_countries <- reactive({
    amzndfs %>% 
      filter(country != "UKS") %>%
      select(country) %>% 
      group_by(country) %>% 
      summarise(Count = n()) %>%
      arrange(desc(Count))
  })
  
  content_logic_countries <- reactive({
    if(str_detect(input$metric,"Top")==TRUE){
      content_with_countries() %>%
        head(5) %>%
        e_charts(country) %>%
        e_pie(Count, radius = c("50%", "70%")) %>%
        e_tooltip() %>%
        e_legend(
          show  = FALSE# might be of use
        ) 
      
    } else{
      
      content_with_countries() %>%
        tail(5) %>%
        e_charts(country) %>%
        e_pie(Count, radius = c("50%", "70%")) %>%
        e_tooltip() %>%
        e_legend(
          show  = FALSE# might be of use
        )  
      
    }
    
  })
  
  
  output$plotdonut <- renderEcharts4r({
    content_logic_countries() %>% e_theme("inspired")
  })
  
  
}