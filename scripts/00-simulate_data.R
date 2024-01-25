#### Preamble ####
# Purpose: Simulates 2023 TTC Bus Delay Data
# Author: Xavier Ibanez-Padron
# Date: 22 January 2024
# Contact: xavier.ibanezpadron@mail.utoronto.ca
# License: MIT
# Pre-requisites: N/A
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(lubridate)
#### Simulate data ####

# For reproducibility
set.seed(616)

# Generate random numbers for Delay between 0-300, skewed towards smaller nums
rand_nums <- rexp(365, rate = 1/100)
scaled_nums <- round(pmin(rand_nums / max(rand_nums) * 300, 300), digits = 0)

# All possible Incidents
incidents <- c("Cleaning", "Diversion", "Emergency Services", "General Delay", 
               "Held By", "Investigation", "Mechanical", "Off Route",
               "Operations", "Road Blocked", "Security", "TTC Collision", "Vision"
               )

# Inspired by code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html#simulate
sim_data <- 
  tibble(
    # Randomly pick dates, without replacement, 365 times
    # This ensures a sample spread of the entirety of 2023
    "Date" = sample(
      x = seq(
        as.Date('2023/01/01'), 
        as.Date('2023/12/31'), 
        by="day"
        ),
      size = 365,
      replace = FALSE
      ),
    # Randomly pick times of the day with replacement
    "Time" = sprintf(
      "%02d:%02d", 
      floor(runif(365, 0, 24)), 
      floor(runif(365, 0, 60))
      ),
    # Randomly pick a TTC bus route with replacement
    # (routes 7-135, consisting of most routes)
    "Route" = as.character(
      sample(
        x = 7:135,
        size = 365,
        replace = TRUE
        )
      ),
    # Randomly pick days of the week
    "Day" = sample(
      x = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"),
      size = 365,
      replace = TRUE
      ),
    # Delay time
    "Delay (min)" = scaled_nums,
    # Randomly pick incident reasons
    "Incident" = sample(
      x = incidents,
      size = 365,
      replace = TRUE
    )
)

sim_data

# Graph a bar plot plotting incidents and their occurances
ggplot(sim_data, aes(x = Incident, fill = Incident)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Incident Type", y = "Count", title = "TTC Bus Delays by Incident Type") + 
  theme(legend.position = "none")

ggplot(sim_data, aes(x = Day, y = as.POSIXct(Time, format = "%H:%M"))) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Day of the Week", y = "Time of Day", title = "Spread of Times of Delays for Each Day of the Week") +
  theme(legend.position = "none")
