library(tidyverse) 
library(ggplot2)    

url <- "https://covid.ourworldindata.org/data/owid-covid-data.csv"
data <- read_csv(url)  # Import the data from the provided URL


# Filter data for Germany, UK, France, and Spain
germany_uk_france_spain <- data %>%
  filter(location %in% c("Germany", "United Kingdom", "France", "Spain"))

# Convert date column to Date format
germany_uk_france_spain$date <- as.Date(germany_uk_france_spain$date)

# Group data by location and month, and calculate cumulative cases

germany_uk_france_spain_cumulative <- germany_uk_france_spain %>%
  group_by(location, month = format(date, "%Y-%m")) %>%
  summarize(cumulative_cases = sum(total_cases, na.rm = TRUE))

ggplot(data=germany_uk_france_spain_cumulative, aes(x=month, y=cumulative_cases, group=1, color = location)) +
  geom_point()+
  #geom_line() +
  #geom_smooth()+
  labs(title = "COVID-19 confirmed cases in europa as of 25.05.2023",
              x = "Month",
              y = "Cumulative Cases") +
  scale_x_discrete(limits = c("2019-12", "2020-01", "2020-02", "2020-03",
                                     "2020-04", "2020-05", "2020-06", "2020-07",
                                     "2020-08", "2020-09", "2020-10", "2020-11",
                                     "2020-12", "2021-01", "2021-02", "2021-03",
                                     "2021-04", "2021-05", "2021-06", "2021-07",
                                     "2021-08", "2021-09", "2021-10", "2021-11",
                                     "2021-12", "2022-01", "2022-02", "2022-03",
                                     "2022-04", "2022-05", "2022-06", "2022-07",
                                     "2022-08", "2022-09", "2022-10", "2022-11",
                                     "2022-12", "2023-01", "2023-02", "2023-03",
                                     "2023-04", "2023-05"))+
  scale_color_manual(values = c("Germany" = "blue", "United Kingdom" = "red",
                                 "France" = "green", "Spain" = "purple"))


