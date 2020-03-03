library(dplyr)

df_location <- read.csv("data/datausa.io/Income by Location.csv",
                        stringsAsFactors = F)

get_race_aggregate <- function(dataset) {
  table <- dataset %>%
    filter(Race != "Total") %>%
    group_by(Geography, Race) %>%
    summarize(household_income = sum(Household.Income.by.Race)) %>%
    mutate(county_income = sum(household_income)) %>% 
    group_by(Geography) %>%
    arrange(desc(household_income), .by_group = T) %>%
    arrange(desc(county_income))
  
  return(table)
}

get_year_aggregate <- function(dataset) {
  table <- dataset %>% 
    filter(Race != "Total") %>% 
    group_by(Year, Race) %>% 
    summarize(household_income = sum(Household.Income.by.Race)) %>% 
    ungroup()
}
