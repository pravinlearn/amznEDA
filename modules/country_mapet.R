# Echarts4r map module
import("mailR")
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
import("htmltools")
expose("utilities/getMetricsChoices.R")
expose("utilities/getTimeFilterChoices.R")
expose("utilities/getDataByTimeRange.R")
expose("utilities/getPercentChangeSpan.R")

consts <- use("constants.R")

ui <- function(id) {
  ns <- NS(id)
  
  # select only those metrics that are available per country
  choices <- c("Email")
  
  tagList(
    tags$div(
      class = "panel-header",
      selectInput(
        ns("email"), "Select metric for the map",
        choices,
        width = NULL,
        selectize = TRUE
      )
    )

  )
}

init_server <- function(id, amzndf) {
  callModule(server, id, amzndf)
}

server <- function(input, output, session, amzndf) {
  
  

  }


