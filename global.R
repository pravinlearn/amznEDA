library(dplyr) # for data wrangling
library(tidytext)
library(mailR)
library(reactable)# for NLP
library(plotly)
library(stringr) # to deal with strings
library(wordcloud) # to render wordclouds
library(knitr) # for tables
library(DT) # for dynamic tables
library(tidyr)
library(wordcloud2)
library(readr)
library(tinytex)
library(huxtable)
library(tm)
library(ggplot2)
library(shinyhelper)
library(echarts4r)
library(textdata)
library(janeaustenr)
library(dplyr)
library(stringr)
library(reshape2)
library(shiny)
library(modules)
library(dplyr)
library(tidyr)
library(lubridate)
library(dygraphs)
library(sass)
library(glue)
library(ggplot2)
library(RColorBrewer)
library(xts)
library(echarts4r)
library(htmltools)
library(reshape2)

##########library(htmltools)
###########################################################
# Function compiling sass files to one css file
sass(
  sass_file("styles/main.scss"),
  output = "www/main.css",
  options = sass_options(output_style = "compressed"),
  cache = NULL
)

# Constants
consts <- use("constants.R")

# Modules
metric_summary <- use("modules/metric_summary.R")
map_chart <- use("./modules/map_chart.R")
time_chart <- use("./modules/time_chart.R")
breakdown_chart <- use("./modules/breakdown_chart.R")
breakdown_charts <- use("./modules/breakdown_charts.R")
country_mapet <- use("./modules/country_mapet.R")

amazon_prime_titles <- read_csv("data/amazon.csv")

amazon_prime_titles  -> amzn

amzn %>% mutate(director =ifelse(is.na(director) == TRUE,"DirJam",director),
                cast =ifelse(is.na(cast) == TRUE,"Tom,Jery",cast),
                country =ifelse(is.na(country) == TRUE,"UKS",country)
) %>% select(-rating,-date_added) -> amzn

amzn[sapply(amzn, is.character)] <- lapply(amzn[sapply(amzn, is.character)], 
                                           as.factor)
amzn %>% arrange(desc(release_year)) -> amzn