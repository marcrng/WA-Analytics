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

# Gender Page
pg_gender <- tabPanel(
  "Gender",
  titlePanel("Comparison by Gender"),
  sidebarLayout(
    
    # Sidebar content
    sidebarPanel(
      
      # Arrange picker
      selectInput(
        inputId = "arr_var",
        label = "Sort by:",
        selected = "f_gap",
        choices = c(
          "Hourly Pay - Women" = "Female.Avg.Hrly.Rate",
          "Hourly Pay - Men" = "Male.Avg.Hrly.Rate",
          "Largest Gap - Women to Men" = "f_gap",
          "Largest Gap - Men to Women" = "m_gap"
        )
      ),
      
      # Observation slider
      sliderInput(
        "slider",
        "Number of observations:",
        min = 10,
        max = nrow(df_genders),
        step = 1,
        value = 444,
        animate = animationOptions(interval = 100, loop = F)
      )
    ),
    mainPanel(plotlyOutput(
      outputId = "gender_plotly"
    ))
  )
)

# Occupation page
pg_occ <- tabPanel(
  "Occupation",
  titlePanel("Comparison by Occupation"),
  sidebarLayout(
    # Sidebar content
    sidebarPanel(
      
      
    ),
    mainPanel(plotlyOutput(
      outputId = "occ_plotly"
    ))
  )
)

# Race and location page
pg_loc <- tabPanel(
  "Race and Location",
  titlePanel("Comparison by Race and Location"),
  sidebarLayout(
    
    # Sidebar content
    sidebarPanel(
      
    ),
    mainPanel()
  )
)

ui <- navbarPage(theme = "help.css",
                 "WA Salary Analytics",
                 pg_overview,
                 pg_occ,
                 pg_loc,
                 pg_gender
)
