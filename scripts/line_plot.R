library(dplyr)
library(plotly)
source("scripts/aggregate_tbl.R")

get_line_plot <- function(dataset) {
  plot_ly(dataset, x = ~Year, y = ~household_income, color = ~Race) %>% 
    add_lines(hovertemplate = paste("Average income: $%{y:.0f}")) %>%
    layout(title = "Average Household Income YOY",
           xaxis = list(title ="Year"),
           yaxis = list(title = "Average Household Income"),
           hovermode = "compare")
}
