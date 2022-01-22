

###########################BasicDataCleaning######################################



server <- function(input, output, session) {

  metric_summary$init_server("sales",
                             amzndf= amzn,type1 = "Movie",type2 = "TV Show")
  metric_summary$init_server("production",
                             amzndf= amzn, type1= "TV Show",type2 ="Movie")
  metric_summary$init_server("users",
                             amzndf= amzn,type1 = "Movie",type2 = "TV Show")
  metric_summary$init_server("complaints",
                             amzndf= amzn, type1= "TV Show",type2 ="Movie")
  
  time_chart$init_server("time_chart",amzndfs = amzn)
  breakdown_chart$init_server("breakdown_chart")
  breakdown_charts$init_server("breakdown_charts", amzndf = amzn)
  map_chart$init_server("map_chart", amzndf = amzn)
  breakdown_chartstwo$init_server("breakdown_chartstwo")
  
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(Sys.time(), 'AmznPrime.csv', sep='')
    },
    content = function(file) {
      write.csv(amzn, file, row.names = FALSE)
    }
  )

}