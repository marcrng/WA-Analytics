library(dplyr)
library(ggplot2)
library(plotly)
source("scripts/aggregate_tbl.R")

get_bar_chart <- function(dataset) {
  # Return only 3 highest earning races from each county
  dataset <- dataset %>%
    top_n(3, household_income)
    
  # Create bar chart
  bar_chart <- ggplot(dataset) +
    geom_col(
      mapping = aes(x = reorder(Geography, -household_income),
                    y = household_income,
                    fill = Race,
                    group = -household_income),
      position = "dodge"
    ) +
    
    labs(
      title = "Average Household Income by Race and County in WA",
      x = "County",
      y = "Average Household Income"
    ) +
    scale_y_continuous(breaks = scales::pretty_breaks(n = 10))
  
  a <- list(
    title = "AXIS TITLE",
    showticklabels = TRUE,
    tickangle = 45,
    exponentformat = "E"
  )
  
  # Convert to plotly chart -- ggplot2 visualization was unsatisfactory
  ggplotly(bar_chart, tooltip = "Race") %>% 
    layout(xaxis = a)
}

get_bar_chart(get_race_aggregate(df_location))
