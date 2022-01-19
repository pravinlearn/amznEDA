# Metric module with summary

import("shiny")
import("dplyr")
import("htmltools")
import("glue")
import("echarts4r")
export("ui")
export("init_server")
import("stringr")
expose("constants.R")
expose("utilities/getMetricsChoices.R")
expose("utilities/getTimeFilterChoices.R")
expose("utilities/getDataByTimeRange.R")
expose("utilities/getPercentChangeSpan.R")



ui <- function(id) {
  ns <- NS(id)
  choices <- getMetricsChoicesByCategory(id)

  tagList(
    selectInput(
      ns("summary_metric"), "Metric",
      choices,
      width = NULL,
      selectize = TRUE,
      selected = choices[[1]]
    ),
    # verbatimTextOutput(ns("summary"))
    echarts4rOutput(ns("plot"),height = "250px"),
    
  )
}

init_server <- function(id,amzndf,type1,type2) {
  callModule(server,id,amzndf,type1,type2)
}

server <- function(input, output, session, amzndf,type1,type2) {
  

    amazon_Tv_Movie_Count_hit <- reactive({
      
      
      amzndf %>%

        mutate(Status = if_else(Rating > 8,"Hits","Flop")) %>%
        mutate(type = if_else(type == type1,paste0(type1," ",Status),paste0(type2," ",Status))) %>%
        select(type) %>% 
        group_by(type) %>% 
        summarise(Count = n()) %>%
mutate(grp = ifelse(str_detect(type,"Movie"),"movie","tv"))%>%
       group_by(grp) %>% mutate(proc = (Count/sum(Count)))  %>%
      filter(type == input$summary_metric)
        
        
        
      
      
      
      
    })
      
      
    
    
    
    output$plot <- renderEcharts4r({
      df <- data.frame(val = c(amazon_Tv_Movie_Count_hit()$proc[1], 0.5, 0.4))
      
      df |>
        e_charts() |>
        e_liquid(val) |>
        e_theme("shine")
    })
  }  