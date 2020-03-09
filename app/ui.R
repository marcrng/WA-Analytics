library(shiny)
library(dplyr)
library(plotly)
library(shinyWidgets)
library(scatterD3)


jobtitle_list <- read.csv("../data/Comparison by Gender.csv", stringsAsFactors = F)

# Remove any rows with NA
jobtitle_list <- jobtitle_list[complete.cases(jobtitle_list),] %>% 
    select(Jobtitle)

pg_overview <- tabPanel("Overview",# Page 1 label
                        titlePanel("Overview"),# Page 1 title
                        fluidPage(#uiOutput('overview')
                            includeMarkdown("overview.md")))


pg_gender <- tabPanel("Gender",
                      titlePanel("Gender"),
                      sidebarLayout(
                          
                          # Sidebar content
                          sidebarPanel(verticalLayout(
                              
                              # Arrange Picker
                              selectInput(
                                  inputId = "arr_var",
                                  label = "Sort by:",
                                  choices = c(
                                      
                                  ),
                                  selected = "High"
                              )
                          )),
                          mainPanel(scatterD3Output(
                              outputId = "occ_scatter",
                              height = 8000
                          ))
                      )
)

pg_loc <- tabPanel("Race and Location",
                   titlePanel("Race and Location"))

pg_occ <- tabPanel("Occupations",
                   titlePanel("Occupations"))

ui <- navbarPage("WA Salary Analytics",
                 pg_overview,
                 pg_gender,
                 pg_loc,
                 pg_occ)
