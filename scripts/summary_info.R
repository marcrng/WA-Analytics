df_location <- read.csv("data/datausa.io/Income by Location.csv",
                        stringsAsFactors = F)

info_list <- list()

# Add number of observations (rows) to list
info_list$row_num <- nrow(df_location)

# Add number of rows to list
info_list$col_num <- ncol(df_location)

# Number of unique race values in 'Race' column (including 'two or more'
# as its own race and excluding 'Total')
info_list$race_num <- length(unique(df_location$Race)) - 1

# Number of unique counties surveyed
info_list$county_num <- length(unique(df_location$Geography))

# Number of years surveyed
info_list$years_num <- length(unique(df_location$Year))
