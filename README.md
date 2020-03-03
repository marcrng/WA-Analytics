# Final Project ([Report Link](https://marcrng.github.io/self/))
## Domain of Interest
- **Why are you interested in this field/domain? (2-3 sentences)**
    - To explore wage trends in Washington in terms of location/demographic
    - To find potential patterns in compensation for different occupations
    - To compare wages in Seattle by occupation and gender

- **What other examples of data driven projects have you found related to this domain (share at least 3)?**
    - [_Income by Location, data.io_](https://datausa.io/profile/geo/washington#income_geo) by datausa.io. 
        - Visualizes the median household income by WA counties. Visualization can be filtered by race
    - [_The Top Charts of 2016_](https://www.epi.org/publication/the-top-charts-of-2016-13-charts-that-show-the-difference-between-the-economy-we-have-now-and-the-economy-we-could-have/)
        - Various charts visualizing wage trends and disparaties in America.
    - [_Pewresearch.org_](https://www.pewresearch.org/fact-tank/2018/08/07/for-most-us-workers-real-wages-have-barely-budged-for-decades/)
        - Comparison of real wage growth, accounting for inflation.

- **What data-driven questions do you hope to answer about this domain (share at least 3)?**
    - How do wage growth trends differ by location/demographic?
        - Can create visualizations of change in year-to-year median income by location and race to show similarities or differences.
    - Are there compensation disparaties between men and women working for the city of Seattle?
        - Can create visualizations of wage comparisons from city of Seattle data. Can also explore trends by occupation and number of each gender employed.
    - Which occupation group had the most growth in wages in recent years in Washington?
        - Can create visualizations of wage growth over time using Washington wage data. Can compare this growth to other metrics such as dollar value or other metric such as S&P 500

***
## Finding Data (at least 3 datasets)

### _Income by Location.csv_
- **Where did you download the data (e.g., a web URL)?**
    - https://datausa.io/api/data?Geography=04000US53:children&measure=Household%20Income%20by%20Race,Household%20Income%20by%20Race%20Moe&drilldowns=Race

- **How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**
    - This data was collected by the [US Census](https://www.census.gov/en.html), through the [American Community Survey](https://www.census.gov/programs-surveys/acs/methodology.html) (ACS). It is generated through a survey that is distributed nationally and samples about 3.54 million addresses each year. The survey aims to collect data on social, economic, housing, and demographic characteristics of Americans.

- **How many observations (rows) are in your data?**
    - 935

- **How many features (columns) are in the data?**
    - 9

- **What questions (from above) can be answered using the data in this dataset?**
    - How wage growth trends differ by location/demographic.
    
***
### _City_of_Seattle_Wages___Comparison_by_Gender_-_All_Job_Classifications.csv_
- **Where did you download the data (e.g., a web URL)?**
    - https://catalog.data.gov/dataset/city-of-seattle-wages-comparison-by-gender-all-job-classifications-e471a
- **How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**
    - The city of Seattle collected this data through public records, surveys, and forms submitted to the city.
- **How many observations (rows) are in your data?**
    - 872
- **How many features (columns) are in the data?**
    - 12
- **What questions (from above) can be answered using the data in this dataset?**
    - What disparities, if any, are present for wages between men and women working for the city of Seattle

***
### _Employment by Occupations.csv_
- **Where did you download the data (e.g., a web URL)?**
    - https://datausa.io/api/data?Geography=04000US53&measure=Total%20Population,Total%20Population%20MOE%20Appx,Average%20Wage,Average%20Wage%20Appx%20MOE,Record%20Count&Workforce%20Status=true&Record%20Count%3E=5&drilldowns=Detailed%20Occupation&parents=true&debug=true
- **How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**
    - This data was collected by the [US Census](https://www.census.gov/en.html), through the [American Community Survey](https://www.census.gov/programs-surveys/acs/methodology.html) (ACS). It is generated through a survey that is distributed nationally and samples about 3.54 million addresses each year. The survey aims to collect data on social, economic, housing, and demographic characteristics of Americans.
- **How many observations (rows) are in your data?**
    - 2072
- **How many features (columns) are in the data?**
    - 23
- **What questions (from above) can be answered using the data in this dataset?**
    - Which occupation group had the largest wage growth in recent years
