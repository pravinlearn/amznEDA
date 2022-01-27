# Load utility functions
source("utilities/getTimeFilterChoices.R")
source("utilities/getMetricsChoices.R")
source("utilities/getExternalLink.R")

# Load constant variables
consts <- use("constants.R")
# Html template used to render UI
fixedPage(
  useShinyjs(),  # Include shinyjs
  

htmlTemplate(
  

  "www/index.html",
  appTitle = consts$app_title,
  appVersion = consts$app_version,
  mainLogo = getExternalLink("https://appsilon.com/", "main", consts$appsilonLogo),
  dashboardLogo = getExternalLink("https://shiny.rstudio.com/", "dashboard", consts$shinyLogo),
  downloaddata = downloadButton("downloadData", "Export"),
   sendmail  =actionButton("smail","Email",icon = icon("mail-bulk")),
  genreporting =  downloadButton("reportGen", "Report"),

  tvShowhits = metric_summary$ui("sales"),
  tvShowflops = metric_summary$ui("production"),
  movieHits =metric_summary$ui("users"),
  movieFlop = metric_summary$ui("complaints"),
  countrycontents = time_chart$ui("time_chart"),
  
  gneresContent = breakdown_chart$ui("breakdown_chart"),
  dataset_react = map_chart$ui("map_chart"),
  text_analyz = breakdown_charts$ui("breakdown_charts"),
  pos_neg_words = breakdown_chartstwo$ui("breakdown_chartstwo"),
  
  
  marketplace_website = consts$marketplace_website
  
  
)
)