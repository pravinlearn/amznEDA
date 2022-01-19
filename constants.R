# common variables for generating sample data and shiny app (ui & server)
import("dplyr")
import("htmltools")

app_title <- "OTT Dashboard"
app_version <- "1.0.0"
data_last_day <- "2020-05-10" %>% as.Date()
data_first_day <- "2015-01-01" %>% as.Date()
marketplace_website <- "https://appsilon.com/"

metrics_list <- list(
  revenue = list(
    id = "Tvid",
    title = "Tv Shows",
    currency = "$",
    category= "soc",
    legend = "q"
  ),
 
  profit = list(
    id = "hit_count",
    title = "TV Show Hits",
    currency = "$",
    category= "sales",
    legend = "Profit"
  ),
  orders_count = list(
    id = "flop_count",
    title = "TV Show Flop",
    currency = NULL,
    category= "production",
    legend = "Number of orders"
  ),
  
  
  cost = list(
    id = "cost",
    title = "Movies",
    currency = "$",
    category= "socs",
    legend = "Cost",
    invert_colors = TRUE
  ),
  produced_items = list(
    id = "movie_flop",
    title = "Movie Flop",
    currency = NULL,
    category= "complaints",
    legend = "Produced items"
  ),
  users_active = list(
    id = "movie_hit",
    title = "Movie Hits",
    currency = NULL,
    category= "users",
    legend = "Active users"
  )
  
  ,
  users_dropped_out = list(
    id = "users_dropped_out",
    title = "Average Rating",
    currency = NULL,
    category= "users1",
    legend = "Dropped out users",
    invert_colors = TRUE
  ),
  complaints_opened = list(
    id = "complaints_opened",
    title = "Opened Complaints",
    currency = NULL,
    category= "complaints1",
    legend = "Opened complaints",
    invert_colors = TRUE
  ),
  complaints_closed = list(
    id = "complaints_closed",
    title = "Closed Complaints",
    currency = NULL,
    category= "complaints1",
    legend = "Closed complaints"
  )
)

map_metrics <- c(
  "revenue",
  "orders_count",
  "users_active",
  "users_dropped_out",
  "complaints_opened",
  "complaints_closed"
)

prev_time_range_choices <- list("Previous Year" = "prev_year", "Previous Month" = "prev_month")

appsilonLogo <- HTML("
  <svg class='logo-svg' viewBox='0 0 660.52 262.96'>
    <use href='assets/icons/icons-sprite-map.svg#appsilon-logo'></use>
  </svg>
")

shinyLogo <- HTML("
  <svg class='logo-svg' viewBox='0 0 100 68'>
    <use href='assets/icons/icons-sprite-map.svg#shiny-logo'></use>
  </svg>
")

colors <- list(
  white = "#FFF",
  black = "#0a1e2b",
  primary = "#0099F9",
  secondary = "#15354A",
  ash = "#B3B8BA",
  ash_light = "#e3e7e9"
)