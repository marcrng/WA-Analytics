library(dplyr)
library(plotly)
source("scripts/aggregate_tbl.R")

get_line_plot <- function(dataset) {
  plot_ly(dataset, labels = ~Race, values = ~annual_income, type = "pie") %>% 
    layout(
      title = "WA 2018 Income by Race"
    )
}
