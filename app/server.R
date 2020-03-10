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
        df_genders <- df_genders[complete.cases(df_genders), ]
        df_genders <- df_genders %>% 
            filter(Jobtitle != "Grand Total")
        
        data <- reactive({
            df_genders[1:input$slider,]
        })
        
        scatterD3(
            x = data()[,input$x_var],
            y = data()[,input$y_var],
            xlab = input$x_var,
            ylab = input$y_var,
            col_var = data()[,input$col_var],
            transitions = T,
            tooltip_text = paste0(
                "Job Title: ", data()[,"Jobtitle"],
                "</br> Average Hourly Rate: ",
                data()[,"Total.Avg.Hrly.Rate"], "$",
                "</br> Total Number Employed: ",
                data()[,"Total.No..Empl"]
            )
        )
    })
    
    
    output$plotly <- renderPlotly({
        
        
        # Filter NA from dataframe
        df_genders <- read.csv("../data/Comparison by Gender.csv", stringsAsFactors = F)
        df_genders <- df_genders[complete.cases(df_genders), ] %>%
            mutate(m_gap  = Male.Avg.Hrly.Rate - Female.Avg.Hrly.Rate) %>%
            mutate(f_gap  = Female.Avg.Hrly.Rate - Male.Avg.Hrly.Rate) %>%
            arrange_at(interp(input$arr_var)) %>%
            filter(Jobtitle != "Grand Total")
        
        # Job title vs. hourly rate
        plot_ly(
            data = df_genders,
            x = ~Male.Avg.Hrly.Rate,
            y = ~ factor(Jobtitle, levels = Jobtitle),
            name = "Men",
            type = "scatter",
            mode = "markers",
            marker = list(color = "blue"),
            height = 8000
        ) %>%
            add_trace(
                x = ~Female.Avg.Hrly.Rate,
                y = ~ factor(Jobtitle, levels = Jobtitle),
                name = "Women",
                type = "scatter",
                mode = "markers",
                marker = list(color = "pink")
            ) %>%
            layout(
                title = "Wage Comparison by Gender",
                plot_bgcolor = "transparent",
                paper_bgcolor = "transparent",
                font = list(color = "lightgrey"),
                margin = list(
                    l = 50,
                    r = 50,
                    b = 100,
                    t = 50,
                    pad = 1
                ),
                xaxis = list(
                    title = "Average Hourly Rate",
                    tickmode = "linear",
                    showline = F,
                    showticklabels = F,
                    showgrid = F
                ),
                yaxis = list(
                    ticks = "inside",
                    dtick = 1,
                    ticklen = 5,
                    tickwidth = 2,
                    tickcolor = toRGB("purple"),
                    type = "category",
                    title = "<b> Job Title <b>",
                    tickmode = "linear",
                    range = c(5, max(NROW(df_genders$Jobtitle))+1),
                    gridcolor = "#e6e6e61c"
                )
            )
    })
}
