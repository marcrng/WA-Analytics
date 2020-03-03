library(dplyr)

df_location <- read.csv("data/datausa.io/Income by Location.csv",
                        stringsAsFactors = F)

# Returns table providing county, race, avg income, total county income
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

# Returns table providing average income among all counties by race
# and year
get_year_aggregate <- function(dataset) {
  table <- dataset %>% 
    filter(Race != "Total") %>% 
    group_by(Year, Race) %>% 
    summarize(household_income = sum(Household.Income.by.Race)) %>%
    mutate_at(vars(household_income), funs(./ 20)) %>% 
    ungroup()
  
  return(table)
}

# Returns table providing 2018 total income by race for all counties
get_state_aggregate <- function(dataset) {
  table <- dataset %>% 
    filter(Race != "Total", Year == "2018") %>% 
    group_by(Race) %>% 
    summarize(annual_income = sum(Household.Income.by.Race))
}
