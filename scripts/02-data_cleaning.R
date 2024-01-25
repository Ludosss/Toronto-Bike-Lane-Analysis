#### Preamble ####
# Purpose: Cleaning the raw TTC bus delay data
# Author: Xavier Ibanez-Padron
# Date: 22 January 2024
# Contact: xavier.ibanezpadron@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # 01-download_data.R
# Any other information needed? N/A

#### Workspace setup ####
library(tidyverse)
library(readxl)
library(openxlsx)

#### Clean data ####

# Variable creation
g <- "guess"
dataset <- "inputs/data/unedited_bus_data.xlsx"
types <- c(g, "text", g, g, g, g, g, g, g, g)

# Reading dataset
raw_data <- read_excel(dataset, col_types = types)

# Rearranging/renaming columns/names and fixing types
# Selecting only variables necessary for analysis
cleaned_data <- raw_data %>% 
  relocate(Time, .after = Date) %>% 
  relocate(Incident, .after = `Min Delay`) %>% 
  mutate(Date = as.Date(Date, format="%Y-%m-%d")) %>% 
  rename(`Delay (min)` = `Min Delay`) %>% 
  select(Date, Time, Route, Day, `Delay (min)`, Incident) %>%
  mutate(Incident = case_when(
    Incident == "Cleaning - Unsanitary" ~ "Cleaning",
    Incident == "Operations - Operator" ~ "Operations",
    Incident == "Road Blocked - NON-TTC Collision" ~ "Road Blocked",
    Incident == "Collision - TTC" ~ "TTC Collision",
    Incident == "Utilized Off Route" ~ "Off Route",
    TRUE ~ Incident
  ))

# Write cleaned data as excel file
write.xlsx(
  x = cleaned_data,
  file = "outputs/data/cleaned_bus_data.xlsx"
)


