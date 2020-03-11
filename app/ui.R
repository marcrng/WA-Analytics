library(shiny)
library(dplyr)
library(plotly)
library(shinyWidgets)
library(scatterD3)
library(forcats)

# Read genders dataset
df_genders <- read.csv("data/Comparison by Gender.csv",
                       stringsAsFactors = F)

# Read occupation dataset
df_occ <- read.csv("data/Employment by Occupations.csv",
                   stringsAsFactors = F)

# Read income dataset
df_inc <- read.csv("data/Income by Location.csv",
                   stringsAsFactors = F)


jobtitle_list <- read.csv("data/Comparison by Gender.csv", stringsAsFactors = F)

# Remove any rows with NA
jobtitle_list <- jobtitle_list[complete.cases(jobtitle_list), ] %>%
  select(Jobtitle)


pg_overview <- tabPanel("Overview", # Page 1 label
                        titlePanel(" "), # Page 1 title
                        fluidPage(includeMarkdown("overview.md"))
)

# Gender Page
pg_gender <- tabPanel(
  "Gender",
  titlePanel("Comparison by Gender"),
  sidebarLayout(

    # Sidebar content
    sidebarPanel(

      # Graph description
      HTML("Comparison of occupations in Seattle plotted against average
           hourly wages and occupation for men and women
           </br></br>"),

      # Arrange picker
      selectInput(
        inputId = "arr_var",
        label = "Sort by:",
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
      ),

      HTML("Scroll to view graph.
           </br> Pay gaps indicated by yellow line")
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
      width = 3,

      # Graph description
      HTML("Comparison of occupations in Washington plotted against
      average annual salary. Only 6 groups may be selected manually.
           However, all occupations can be selected to provide an overview.
           </br></br>"),

      # Occupation picker
      pickerInput(
        inputId = "occ_input",
        label = "Choose up to 6 occupation groups to plot:",
        multiple = T,
        choices = c(unique(df_occ$Broad.Occupation)),
        selected = c("Computer & mathematical occupations",
                     "Business & financial operations occupations",
                     "Education, Training, & Library Occupations"),
        options = list("max-options" = 6,
                       "actions-box" = T)
      ),

      # Year Picker
      selectInput(
        inputId = "year_input",
        label = "Year:",
        choices = c(unique(df_occ$Year)),
        selected = 2018
      )
    ),

    # Main Panel content
    mainPanel(plotlyOutput(
      outputId = "occ_bar"
    ))
  )
)

# Race and location page
pg_loc <- tabPanel(
  "Year",
  titlePanel("Comparison by Year"),
  sidebarLayout(

    # Sidebar content
    sidebarPanel(

      # Graph description
      HTML("Comparison of change in occupations between 2014 and 2018
           plotted against average annual salary and total employed
           </br></br>"),

      # Occupation picker - YOY
      selectInput(
        inputId = "occ_input2",
        label = "Choose occupation groups to plot:",
        multiple = T,
        choices = c(unique(df_occ$Broad.Occupation)),
        selected = c("Computer & mathematical occupations",
                     "Business & financial operations occupations",
                     "Education, Training, & Library Occupations")
      ),

      HTML("</br>Use slider below graph to view change between years")

    ),

    # Main Panel content
    mainPanel(plotlyOutput(
      outputId = "occ_line"
    ))
  )
)
# Conclusion page
pg_con <- tabPanel("Conclusions",
                   titlePanel("Conclusions"),
                   fluidPage(includeMarkdown("conclusion.md"))
)

ui <- navbarPage(theme = "help.css",
                 "WA Salary Analytics",
                 pg_overview,
                 pg_occ,
                 pg_loc,
                 pg_gender,
                 pg_con
)
