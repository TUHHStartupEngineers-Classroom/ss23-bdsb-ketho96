library(rvest)
library(tidyverse)

# URL of the category you want to scrape
category_url <- "https://www.rosebikes.de/fahrr%C3%A4der"

# Function to clean and convert prices to numeric format
clean_price <- function(price) {
  price <- gsub("[^0-9,]", "", price)  # Remove any non-numeric characters except comma
  price <- gsub(",", ".", price)      # Replace comma with dot for decimal places
  as.numeric(price)
}

# Scrape the website and extract the desired information
page <- read_html(category_url)

# Extract model names
model_names <- page %>%
  html_nodes(".product-title") %>%
  html_text()

# Extract prices
prices <- page %>%
  html_nodes(".price") %>%
  html_text() %>%
  map_chr(clean_price)

# Create a data frame with the extracted information
data <- tibble(Model = model_names, Price = prices)

# Print the data frame
print(data) %>% 
  head(n=10)
