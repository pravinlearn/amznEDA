



server <- function(input, output, session) {
  
   # observeEvent(input$smail,{
   #   showModal
   # })


  dataModal <- function(failed = FALSE) {
    modalDialog(
      textInput("dataset", "Choose data set",
                placeholder = 'Try "mtcars" or "abc"'
      ),
      span('(Try the name of a valid data object like "mtcars", ',
           'then a name of a non-existent object like "abc")'),
      if (failed)
        div(tags$b("Invalid name of data object", style = "color: red;")),
      
      footer = tagList(
        modalButton("Cancel"),
        actionButton("ok", "OK")
      )
    )
  }
  
  observeEvent(input$smail, {
  showModal(dataModal())
  })
    

  metric_summary$init_server("sales",
                             amzndf= amzn,type1 = "Movie",type2 = "TV Show")
  metric_summary$init_server("production",
                             amzndf= amzn, type1= "TV Show",type2 ="Movie")
  metric_summary$init_server("users",
                             amzndf= amzn,type1 = "Movie",type2 = "TV Show")
  metric_summary$init_server("complaints",
                             amzndf= amzn, type1= "TV Show",type2 ="Movie")
  
  time_chart$init_server("time_chart",amzndfs = amzn)
  breakdown_chart$init_server("breakdown_chart",amzndf =generesCountfile)
  breakdown_charts$init_server("breakdown_charts", amzndf = amzn)
  map_chart$init_server("map_chart", amzndf = amzn)
  breakdown_chartstwo$init_server("breakdown_chartstwo",amzndf1 = sentititle,amzndf2 =descripSentiment)
  
###########################Download Datasets########
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(Sys.time(), 'AmznPrime.csv', sep='')
    },
    content = function(file) {
      write.csv(amzn, file, row.names = FALSE)
    }
  )

  

  #download handler DOCX ====
  output$reportGen <- downloadHandler(
    
    filename = function(){("Amzn_EDA_report.docx")},
    content = function(file) {
      
      withProgress(message = "Preparing the Report. Please wait........", {
        
        tempReport <- file.path(tempdir(),"Prototype_word.Rmd")
        file.copy("Prototype_word.Rmd", tempReport, overwrite = TRUE)
        rmarkdown::render("Prototype_word.Rmd", output_format = "word_document", output_file = file,
                          # params = list(table = a1),
                          envir = new.env(parent = globalenv()),clean=F,encoding="utf-8"
        )
        
      })
    }
  )
  
 
  
  
}

