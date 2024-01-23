#### Preamble ####
# Purpose: Downloads Bus Delay dataset from Open Data Toronto
# Author: Xavier Ibanez-Padron
# Date: 21 January 2024
# Contact: xavier.ibanezpadron@mail.utoronto.ca
# License: MIT
# Pre-requisites: N/A
# Any other information needed? N/A
# Datasets:
  # TTC Bus Delay information from https://open.toronto.ca/dataset/ttc-bus-delay-data/

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(openxlsx)

#### Download data ####

# 2023 TTC Bus Delay Dataset
raw_bus_data <- get_resource(
  resource = "10802a64-9ac0-4f2e-9538-04800a399d1e"
)

#### Save data ####

write.xlsx(
  x = raw_bus_data,
  file = "inputs/data/unedited_bus_data.xlsx"
)
         
