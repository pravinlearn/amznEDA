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
  selectYear = selectInput(
    "selected_year", "Year",
    choices = unique("2021"),
    selectize = TRUE
  ),
  selectMonth = selectInput(
    "selected_country", "Country",
    choices = unique("January"),
    selectize = TRUE
  ),
  previousTimeRange = selectInput(
    "previous_time_range", "Compare to",
    choices = consts$prev_time_range_choices,
    selected = "prev_year",
    selectize = TRUE
  ),
  salesSummary = metric_summary$ui("sales"),
  productionSummary = metric_summary$ui("production"),
  usersSummary =metric_summary$ui("users"),
  complaintsSummary = metric_summary$ui("complaints"),
  timeChart = time_chart$ui("time_chart"),
  
  breakdownChart = breakdown_chart$ui("breakdown_chart"),
  countryMap = map_chart$ui("map_chart"),
  breakdownCharts = breakdown_charts$ui("breakdown_charts"),
  
  marketplace_website = consts$marketplace_website
)
