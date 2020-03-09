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
            gather(category, hourly_rate, -Jobtitle) %>% 
            filter(category == "Female.Avg.Hrly.Rate") %>% 
            arrange(desc(hourly_rate))
        
        
        
        scatterD3(
            data = testdata,
            x = hourly_rate,
            y = Jobtitle,
            col_var = category
        )
    })
    
    # output$occ_scatter <- renderPlotly({
    #     
    #     
    #     # Filter NA from dataframe
    #     df_genders <- read.csv("../data/Comparison by Gender.csv", stringsAsFactors = F) 
    #     df_genders <- df_genders[complete.cases(df_genders), ] %>%
    #         mutate(m_gap  = Male.Avg.Hrly.Rate - Female.Avg.Hrly.Rate) %>% 
    #         mutate(f_gap  = Female.Avg.Hrly.Rate - Male.Avg.Hrly.Rate) %>% 
    #         arrange_at(interp(input$arr_var)) %>%
    #         filter(Jobtitle != "Grand Total")
    # 
    #     # Job title vs. hourly rate
    #     plot_ly(
    #         data = df_genders,
    #         x = ~Male.Avg.Hrly.Rate,
    #         y = ~ factor(Jobtitle, levels = Jobtitle),
    #         name = "Men",
    #         type = "scatter",
    #         mode = "markers",
    #         marker = list(color = "blue")
    #     ) %>% 
    #         add_trace(
    #             x = ~Female.Avg.Hrly.Rate,
    #             y = ~ factor(Jobtitle, levels = Jobtitle),
    #             name = "Women",
    #             type = "scatter",
    #             mode = "markers",
    #             marker = list(color = "pink")
    #         ) %>% 
    #         layout(
    #             title = "Wage Comparison by Gender",
    #             margin = list(
    #                 l = 50,
    #                 r = 50,
    #                 b = 100,
    #                 t = 100,
    #                 pad = 1
    #             ),
    #             xaxis = list(
    #                 tickmode = "linear",
    #                 showline = F,
    #                 showticklabels = F,
    #                 showgrid = F
    #             ),
    #             yaxis = list(
    #                 autotick = FALSE,
    #                 ticks = "inside",
    #                 tick0 = 50,
    #                 dtick = 1,
    #                 ticklen = 5,
    #                 tickwidth = 2,
    #                 tickcolor = toRGB("purple"),
    #                 type = "category",
    #                 title = "<b> Job Titles <b>",
    #                 tickmode = "linear"
    #             )
    #         )
    #     
    # })
}
