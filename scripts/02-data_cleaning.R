#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(readxl)

#### Clean data ####

# Variable creation
g <- "guess"
dataset <- "inputs/data/ttc-bus-delay-data-2023.xlsx"
types <- c(g, "text", g, g, g, g, g, g, g, g)

# Reading dataset
raw_data <- read_excel(dataset, col_types = types)

# Rearranging col's and fixing types
raw_data <- raw_data %>% relocate(Time, .after = Date)
raw_data$Date <- as.Date(raw_data$Date, format="%Y-%m-%d")

# Creating new DateTime column, removing old Date and Time columns
# raw_data <- raw_data %>%
#   mutate(DateTime = make_datetime(year(Date), month(Date), day(Date),
#                                   hour(hm(Time)), minute(hm(Time))))
# 
# raw_data <- raw_data %>% relocate(DateTime)
# raw_data$Time <- NULL
# raw_data$Date <- NULL

raw_data

