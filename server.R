

######EmailPaswd####
pass <- as.character("sen241697")
####################

server <- function(input, output, session) {
 

  dataModal <- function(failed = FALSE) {
    modalDialog(
      img(src = "assets/icons/amznprime.png",width = "18%"),
      br(),
      br(),
      
      textInput("emil", label = NULL,
                placeholder = 'Enter your gmail'
      ),
      
      footer = tagList(
        modalButton("Cancel"),
        actionButton("gomail", "Send")
      )
    )
  }
  
  observeEvent(input$smail, {
  showModal(dataModal())
  })
    
  observeEvent(input$gomail, {
    if(str_detect(input$emil,"gmail") ==TRUE){
      showModal( modalDialog(
        img(src = "assets/icons/amznprime.png",width = "18%"),
        br(),
        br(),
        
        span("The Email has been Sending"),
        footer = NULL
        
      ))
      rmarkdown::render("Prototype_word.Rmd", output_format = "word_document", output_file ="data/Report.docx",
                        # params = list(table = a1),
                        envir = new.env(parent = globalenv()),clean=F,encoding="utf-8"
      )
      send.mail(from="praveenstudy7@gmail.com",
                to=input$emil,
                subject="Amzn Report",
                body="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
                html=T,
                smtp=list(host.name = "smtp.gmail.com",
                          port = 465,
                          user.name = "praveenstudy7@gmail.com",
                          passwd = pass,
                          ssl = T),
                authenticate=T,attach.files = "data/Report.docx")
      
      showModal( modalDialog(
        img(src = "assets/icons/amznprime.png",width = "18%"),
        br(),
        br(),
        
        span("The email was sent sucessfully"),
        
      ))
      
    }else if(is.null(input$emil)==TRUE){
      
      
      
      
      showModal( modalDialog(
        img(src = "assets/icons/amznprime.png",width = "18%"),
        br(),
        br(),
        span("Please Enter your gmail It Can't be Null..."),
        
      ))
      
    }else{
    
      
      showModal( modalDialog(
        img(src = "assets/icons/amznprime.png",width = "18%"),
        br(),
        br(),
        span("It Supports only gmail account.."),
        
      ))
      
    }
    
    
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

