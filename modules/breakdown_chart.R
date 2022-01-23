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
  choices <- c("DataTable View","Movie by Genre","TvShow by Genre")
  
  tagList(
    tags$div(
      class = "panel-header",
      selectInput(
        ns("metricgenrecount"), "Select Metric for Genres",
        choices,
        width = NULL,
        selectize = TRUE
      )
    ),
    
    br(),
    br(),

    #echarts4rOutput(ns("wordclouds_pos_neg"))
    uiOutput(ns("mor_funct")),
    
  )
}

init_server <- function(id,amzndf) {
  callModule(server, id,amzndf)
}

server <- function(input, output, session,amzndf) {
  
  
  output$mor_funct <- renderUI({
    
    if(str_detect(input$metricgenrecount,"DataTable")==TRUE){
      DTOutput(session$ns("gener"))
      
    }else if(str_detect(input$metricgenrecount,"Movie")==TRUE){
      echarts4rOutput(session$ns("gener_viz_movie"))
      
    }else{
      echarts4rOutput(session$ns("gener_viz_TV"))
      
    }
    
    
    
  })
 
  
  
  rv <- reactiveValues(
    data = amzndf %>%
      select(type,listed_in,Count),
    # Clear the previous deletions
    deletedRows = NULL,
    deletedRowIndices = list()
  )
  
 
 
 

  output$gener <- renderDT({
    # genreount() |> 
    #   head() |> 
    #   e_charts(listed_in) |> 
    #   e_pie(Count, roseType = "radius") |> e_theme("inspired") |> e_toolbox_feature() |> e_tooltip()
    
    rv$data
    
  })
  
  
  output$gener_viz_movie <- renderEcharts4r({
    rv$data |>
      filter(type == "Movie") |>
      head() |>
      e_charts(listed_in) |>
      e_pie(Count, roseType = "radius") |> e_theme("inspired") |> e_toolbox_feature() |> e_tooltip() |> e_legend(show = FALSE)
    

  })
  
  
  output$gener_viz_TV <- renderEcharts4r({
    rv$data |>
      filter(type == "TV Show") |>
      
      head() |>
      e_charts(listed_in) |>
      e_pie(Count, roseType = "radius") |> e_theme("inspired") |> e_toolbox_feature() |> e_tooltip() |> e_legend(show = FALSE)
    
    
  })
  
  }


  
  
  
