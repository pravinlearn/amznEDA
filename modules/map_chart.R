# Echarts4r map module
import("reactable")
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
  choices <- c("Amzn prime dataset")
  
  tagList(
    tags$div(
      class = "panel-header",
      selectInput(
        ns("metric"), "Select metric for the map",
        choices,
        width = NULL,
        selectize = TRUE
      )
    ),
    # wordcl(ns("wordclouds")),
    reactableOutput(ns("dttbles"))
    
  )
}

init_server <- function(id, amzndf) {
  callModule(server, id, amzndf)
}

server <- function(input, output, session, amzndf) {
  
  
  rating_stars <- function(rating, max_rating = 5) {
    star_icon <- function(empty = FALSE) {
      tagAppendAttributes(shiny::icon("star"),
                          style = paste("color:", if (empty) "#edf0f2" else "#C70039" ),
                          "aria-hidden" = "true"
      )
    }
    rounded_rating <- floor(rating + 0.5)  # always round up
    stars <- lapply(seq_len(max_rating), function(i) {
      if (i <= rounded_rating) star_icon() else star_icon(empty = TRUE)
    })
    label <- sprintf("%s out of %s stars", rating, max_rating)
    div(title = label, role = "img", stars)
  }
  
  

  output$dttbles <- renderReactable({
   
    
      reactable(
        amzndf %>% 
          head(20) %>%
          select(-show_id,-cast,-director,-country,-listed_in,-duration),
        groupBy = "type",
        searchable = TRUE,
        columns = list(
          "type" = colDef(name = "Type"),
          "title" = colDef(name = "Title"),
          "release_year" = colDef(name = "Year"),
          Rating = colDef(cell = function(value) rating_stars(value)),
          "description" = colDef(name = "Description")
          
        ),
        defaultColDef = colDef(footerStyle = list(fontWeight = "bold"))
      )

    
  })
}


