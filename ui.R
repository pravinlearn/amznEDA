# Load utility functions
source("utilities/getTimeFilterChoices.R")
source("utilities/getMetricsChoices.R")
source("utilities/getExternalLink.R")

# Load constant variables
consts <- use("constants.R")

# Html template used to render UI
htmlTemplate(
  "www/index.html",
  appTitle = consts$app_title,
  appVersion = consts$app_version,
  mainLogo = getExternalLink("https://appsilon.com/", "main", consts$appsilonLogo),
  dashboardLogo = getExternalLink("https://shiny.rstudio.com/", "dashboard", consts$shinyLogo),
  selectYear = downloadButton("downloadData", "Export"),
  selectMonth = actionButton("prev-report","Preview"),
  previousTimeRange =  actionButton("reportgen","Report",icon = icon("file-download")),
  sendMail =  actionButton("smail","Email",icon = icon("email")),
  
  salesSummary = metric_summary$ui("sales"),
  productionSummary = metric_summary$ui("production"),
  usersSummary =metric_summary$ui("users"),
  complaintsSummary = metric_summary$ui("complaints"),
  timeChart = time_chart$ui("time_chart"),
  
  breakdownChart = breakdown_chart$ui("breakdown_chart"),
  countryMap = map_chart$ui("map_chart"),
  breakdownCharts = breakdown_charts$ui("breakdown_charts"),
  breakdownChartstwo = breakdown_chartstwo$ui("breakdown_chartstwo"),
  
  
  marketplace_website = consts$marketplace_website
)
