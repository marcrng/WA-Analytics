library(knitr)
library(shiny)
library(rmarkdown)
library(lazyeval)
library(scatterD3)
library(tidyr)

server <- function(input, output) {
    
    # Read genders dataset
    df_genders <- read.csv("../data/Comparison by Gender.csv",
                           stringsAsFactors = F)
    
    # Read occupation dataset
    df_occ <- read.csv("../data/Employment by Occupations.csv",
                       stringsAsFactors = F)
    
    # Read income dataset
    df_inc <- read.csv("../data/Income by Location.csv",
                       stringsAsFactors = F)
    
    # # Gender scatter3d plot
    # output$occ_scatter <- renderScatterD3({
    #     
    #     df_genders <- read.csv("../data/Comparison by Gender.csv", stringsAsFactors = F)
    #     df_genders <- df_genders[complete.cases(df_genders), ]
    #     df_genders <- df_genders %>% 
    #         filter(Jobtitle != "Grand Total")
    #     
    #     data <- reactive({
    #         df_genders[1:input$slider,]
    #     })
    #     
    #     scatterD3(
    #         x = data()[,input$x_var],
    #         y = data()[,input$y_var],
    #         xlab = input$x_var,
    #         ylab = input$y_var,
    #         col_var = data()[,input$col_var],
    #         transitions = T,
    #         tooltip_text = paste0(
    #             "Job Title: ", data()[,"Jobtitle"],
    #             "</br> Average Hourly Rate: ",
    #             data()[,"Total.Avg.Hrly.Rate"], "$",
    #             "</br> Total Number Employed: ",
    #             data()[,"Total.No..Empl"]
    #         )
    #     )
    # })
    
    # Output gender plotly plot
    output$gender_plotly <- renderPlotly({
        
        # Filter NA from dataframe
        gen_data <- df_genders[complete.cases(df_genders), ] %>%
            
            # Create gap columns
            mutate(m_gap  = Male.Avg.Hrly.Rate - Female.Avg.Hrly.Rate) %>%
            mutate(f_gap  = Female.Avg.Hrly.Rate - Male.Avg.Hrly.Rate) %>%
            filter(Jobtitle != "Grand Total") %>%
            arrange_at(interp(input$arr_var)) %>%
            
            # Filter no. of obs.
            head(input$slider)
        
        # Job title vs. hourly rate
        plot_ly(
            data = gen_data,
            x = ~Male.Avg.Hrly.Rate,
            y = ~ factor(Jobtitle, levels = Jobtitle),
            name = "Men",
            type = "scatter",
            mode = "markers",
            marker = list(color = "lightblue"),
            height = nrow(gen_data) * 20 + 200, # Dynamic plot height
            hoverinfo = "text",
            text = ~paste0(
                "</br> Job Title: ", Jobtitle,
                "</br> Hourly Wage: ", Male.Avg.Hrly.Rate, "$",
                "</br> # Male Employees: ", No..Male.Empl)
        )  %>%
            add_trace(
                x = ~Female.Avg.Hrly.Rate,
                y = ~ factor(Jobtitle, levels = Jobtitle),
                name = "Women",
                type = "scatter",
                mode = "markers",
                marker = list(color = "pink"),
                hoverinfo = "text",
                text = ~paste0(
                    "</br> Job Title: ", Jobtitle,
                    "</br> Hourly Wage: ", Female.Avg.Hrly.Rate, "$",
                    "</br> # Female Employees: ", No..Female.Empl)
            ) %>%
            add_segments(
                x = ~Female.Avg.Hrly.Rate,
                xend = ~Male.Avg.Hrly.Rate,
                y = ~factor(Jobtitle, levels = Jobtitle),
                yend = ~factor(Jobtitle, levels = Jobtitle),
                showlegend = F,
                type = "scatter",
                mode = "lines",
                line = list(color = "yellow", width = 1),
                inherit = F
            ) %>%
            layout(
                title = "Wage Comparison by Gender - Seattle",
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
                    range = c(-1, max(NROW(gen_data$Jobtitle))),
                    gridcolor = "#e6e6e61c"
                )
            )
    })
    
    output$occ_plotly <- renderPlotly({
        
        # Filter any rows with NA
        occ_data <- df_occ[complete.cases(df_occ), ]
        
        
    })
}
