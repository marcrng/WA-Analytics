library(shiny)
library(tidyr)
library(plotly)
library(dplyr)
library(lazyeval)
library(knitr)
source("ui.R")



server <- function(input, output) {
    # Output gender plot
    output$gender_plotly <- renderPlotly({

        # Filter NA from dataframe
        gen_data <- df_genders[complete.cases(df_genders), ] %>%

            # Create gender gap columns
            mutate(m_gap  = Male.Avg.Hrly.Rate - Female.Avg.Hrly.Rate) %>%
            mutate(f_gap  = Female.Avg.Hrly.Rate - Male.Avg.Hrly.Rate) %>%
            filter(Jobtitle != "Grand Total") %>%
            arrange_at(interp(input$arr_var)) %>%

            # Filter no. of obs. reactively
            head(input$slider)

        # Create gender barbell plot
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
                "</br> Hourly Wage: ", "$", Male.Avg.Hrly.Rate,
                "</br> # of Male Employees: ", No..Male.Empl)
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
                    "</br> Hourly Wage: ", "$", Female.Avg.Hrly.Rate,
                    "</br> # of Female Employees: ", No..Female.Empl)
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


    # Filter any rows with NA
    occ_data <- df_occ[complete.cases(df_occ), ] %>%
        select(
            Minor.Occupation.Group,
            Broad.Occupation,
            Detailed.Occupation,
            Average.Wage,
            Total.Population,
            Year
        )
    # Create occupation bar chart
    output$occ_bar <- renderPlotly({

        # Rename bar data for filtering
        occ_bar_data <- occ_data %>%
            group_by(Broad.Occupation) %>%
            arrange(-Average.Wage) %>%
            filter(
                Broad.Occupation %in% !!input$occ_input &
                    Year == !!input$year_input
            )

        # Create occupation bar chart
        plot_ly(
            occ_bar_data,
            type = "bar",
            x = ~reorder(Detailed.Occupation, -Average.Wage),
            y = ~Average.Wage,
            color = ~Broad.Occupation,
            height = 1200,
            hoverinfo = "text",
            text = ~paste0(
                "</br> Occupation: ", Detailed.Occupation,
                "</br> Salary: ", "$", round(Average.Wage),
                "</br> Number Employed: ", Total.Population
            )
        ) %>%
            layout(
                title = "Average Salary by Occupation - WA",
                barmode = "group",
                plot_bgcolor = "transparent",
                paper_bgcolor = "transparent",
                font = list(color = "lightgrey"),
                xaxis = list(
                    title = "Occupation Name",
                    type = "category",
                    tickangle = -45
                ),
                yaxis = list(
                    title = "Average Salary"
                ),
                margin = list(

                ),
                legend = list(
                    x = 0.7,
                    y = 0.9
                )
            )
    })

    # YOY dotplot
    output$occ_line <- renderPlotly({

        # Data for dotplot
        occ_line_data <- occ_data %>%
            filter(Broad.Occupation %in% !!input$occ_input2)

        # Create YOY dotplot
        plot_ly(
            occ_line_data,
            type = "scatter",
            mode = "markers",
            x = ~Total.Population,
            y = ~Average.Wage,
            color = ~Broad.Occupation,
            ids = ~Detailed.Occupation,
            frame = ~Year,
            hoverinfo = "text",
            height = 1200,
            text = ~paste0(
                "</br> Occupation: ", Detailed.Occupation,
                "</br> Salary: ", "$", round(Average.Wage),
                "</br> Number Employed: ", Total.Population
            )
        ) %>%
            layout(
                title = "Wage Trends Year-Over-Year - WA",
                plot_bgcolor = "transparent",
                paper_bgcolor = "transparent",
                font = list(color = "lightgrey"),
                xaxis = list(
                    title = "Total Employed",
                    type = "log",
                    showgrid = F,
                    showticklabels = F,
                    showspikes = T
                ),
                yaxis = list(
                    title = "Average Salary",
                    showspikes = T
                ),
                legend = list(
                    x = 0.67,
                    y = 0.9
                )
            ) %>%
            animation_opts(
                1200, easing = "linear", redraw = F
            )
    })
}
