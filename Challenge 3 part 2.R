library(tidyverse)  
library(ggplot2)    
library(mapdata)  

url <- "https://covid.ourworldindata.org/data/owid-covid-data.csv"
data <- read_csv(url)  # Import the data from the provided URL




# Filter the latest data by location
data <- data %>%
  group_by(location) %>%
  filter(date == max(date)) %>%
  ungroup()

# Calculate the mortality rate
data$mortality_rate <- data$total_deaths / data$population

# Merge the map data and the mortality rate data
map_data <- map_data("world")



merged_data <- merge(map_data, data, by.x = "region", by.y = "location", all.x = TRUE)

# Plot the mortality rate
ggplot() +
  geom_map(data = merged_data, map = map_data,
           aes(x = long, y= lat, map_id = region, fill = mortality_rate),
           color = "black", linewidth = 0.2) +
  scale_fill_gradient(low = "lightblue", high = "darkblue", na.value = "white",
                      name = "Mortality Rate", labels = scales::percent) +
  labs(title = "Distribution of Mortality Rate",
       caption = "Source: Our World in Data",
       fill = "Mortality Rate") +
  theme_void()
