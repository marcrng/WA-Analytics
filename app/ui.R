library(shiny)
library(dplyr)
library(plotly)
library(shinyWidgets)
library(scatterD3)
library(forcats)


jobtitle_list <- read.csv("../data/Comparison by Gender.csv", stringsAsFactors = F)

# Remove any rows with NA
jobtitle_list <- jobtitle_list[complete.cases(jobtitle_list),] %>% 
  select(Jobtitle)


pg_overview <- tabPanel("Overview",# Page 1 label
                        titlePanel("Overview"),# Page 1 title
                        fluidPage(includeMarkdown("overview.md"))
)


pg_gender <- tabPanel(
  "Gender",
  titlePanel("Gender Comparisons"),
  sidebarLayout(
    
    # Sidebar content
    sidebarPanel(
      
      # X column selection
      selectInput(
        inputId = "x_var",
        label = "X Variable:",
        selected = "Female.Avg.Hrly.Rate",
        choices = c(
          "Hourly Pay - Women" = "Female.Avg.Hrly.Rate",
          "Hourly Pay - Men" = "Male.Avg.Hrly.Rate",
          "Total Average Hourly Pay" = "Total.Avg.Hrly.Rate",
          "Number Employed - Women" = "No..Female.Empl",
          "Number Employed - Men" = "No..Male.Empl",
          "Total Employed"= "Total.No..Empl"
        ),
      ),
      # Y column selection
      selectInput(
        inputId = "y_var",
        label = "Y Variable:",
        selected = "Male.Avg.Hrly.Rate",
        choices = c(
          "Hourly Pay - Women" = "Female.Avg.Hrly.Rate",
          "Hourly Pay - Men" = "Male.Avg.Hrly.Rate",
          "Total Average Hourly Pay" = "Total.Avg.Hrly.Rate",
          "Number Employed - Women" = "No..Female.Empl",
          "Number Employed - Men" = "No..Male.Empl",
          "Total Employed"= "Total.No..Empl"
        ),
      ),
      # Color selection
      selectInput(
        inputId = "col_var",
        label = "Color Variable:",
        selected = "No..Male.Empl",
        choices = c(
          "Hourly Pay - Women" = "Female.Avg.Hrly.Rate",
          "Hourly Pay - Men" = "Male.Avg.Hrly.Rate",
          "Total Average Hourly Pay" = "Total.Avg.Hrly.Rate",
          "Number Employed - Women" = "No..Female.Empl",
          "Number Employed - Men" = "No..Male.Empl",
          "Total Employed"= "Total.No..Empl"
        ),
      ),
      # Number of obs. slider
      sliderInput(
        "slider",
        "Number of observations",
        min = 10,
        max = nrow(df_genders),
        step = 1,
        value = 100
      )
    ),
    mainPanel(scatterD3Output(
      outputId = "occ_scatter"
    ))
  )
)

pg_loc <- tabPanel(
  "Race and Location",
  titlePanel("Race and Location"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "arr_var",
        label = "Sort by:",
        choices = c(
          "F" = "Female.Avg.Hrly.Rate",
          "M" = "Male.Avg.Hrly.Rate"
        ),
        selected = "High"
      )
    ),
    mainPanel(plotlyOutput(outputId = "plotly"))
  )
)


pg_occ <- tabPanel("Occupations",
                   titlePanel("Occupations"))

ui <- navbarPage(theme = "help.css",
                 "WA Salary Analytics",
                 pg_overview,
                 pg_gender,
                 pg_loc,
                 pg_occ
)
