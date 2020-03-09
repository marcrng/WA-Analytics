library(knitr)
library(shiny)
library(rmarkdown)
library(lazyeval)
library(scatterD3)
library(tidyr)

server <- function(input, output) {
    # Render occupation scatterplot
    
    output$occ_scatter <- renderScatterD3({
        
        df_genders <- read.csv("../data/Comparison by Gender.csv", stringsAsFactors = F) 
        
        testdata <- df_genders[complete.cases(df_genders), ] %>%
            mutate(m_gap  = Male.Avg.Hrly.Rate - Female.Avg.Hrly.Rate) %>%
            mutate(f_gap  = Female.Avg.Hrly.Rate - Male.Avg.Hrly.Rate) %>%
            filter(Jobtitle != "Grand Total") %>% 
            select(Jobtitle, Female.Avg.Hrly.Rate, Male.Avg.Hrly.Rate) %>% 
            pivot_longer(
                c(Female.Avg.Hrly.Rate, Male.Avg.Hrly.Rate),
                names_to = "category", 
                values_to = "hourly_rate"
                ) %>%
            arrange(hourly_rate) %>% 
            ungroup()
        
        
        
        scatterD3(
            data = testdata,
            x = hourly_rate,
            y = Jobtitle
        )
        
    })
}
