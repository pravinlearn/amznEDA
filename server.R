



server <- function(input, output, session) {
  
   


  generesCountfile_react <- reactive({
    read.csv("data/GeneresCount.csv",header = T)
  }) 
 
  
  sentititle_react <- reactive({
    read.csv("data/sentiment_title.csv",header = T)
  })   

  
  descripSentiment_react <- reactive({
    read.csv("data/sentiment_description.csv",header = T)
  }) 
    

  metric_summary$init_server("sales",
                             amzndf= amznEDA,type1 = "Movie",type2 = "TV Show")
  metric_summary$init_server("production",
                             amzndf= amznEDA, type1= "TV Show",type2 ="Movie")
  metric_summary$init_server("users",
                             amzndf= amznEDA,type1 = "Movie",type2 = "TV Show")
  metric_summary$init_server("complaints",
                             amzndf= amznEDA, type1= "TV Show",type2 ="Movie")
  
  time_chart$init_server("time_chart",amzndfs = amznEDA)
  breakdown_chart$init_server("breakdown_chart",amzndf =generesCountfile)
  breakdown_charts$init_server("breakdown_charts", amzndf = amznEDA)
  map_chart$init_server("map_chart", amzndf = amznEDA)
  breakdown_chartstwo$init_server("breakdown_chartstwo",amzndf1 = sentititle,amzndf2 =descripSentiment)
  
###########################Download Datasets########
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(Sys.time(), 'AmznPrime.csv', sep='')
    },
    content = function(file) {
      write.csv(amznEDA, file, row.names = FALSE)
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

