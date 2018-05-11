
## Setup (libraries, data, etc.)

# Set directory to location w/ aliens 
setwd("~/Documents/The University of Iowa/Spring 2018/JMC-3640/Final Project")

# Load data into R
# Original: https://www.dhs.gov/immigration-statistics/yearbook/2016/table39
aliens <- read.csv("~/Documents/The University of Iowa/Spring 2018/JMC-3640/Final Project/aliens.csv")

# Load necessary libraries
library(ggplot2)
#devtools::install_github('hadley/ggplot2')
library(plotly)



## Cleaning Data

# Change Removals and Returns to numbers
aliens$Removals <- as.numeric(gsub(",", "", aliens$Removals))
aliens$Returns <- as.numeric(gsub(",", "", aliens$Returns))



## Plot cool stuff

# Removals
# ggplot2 graph
aliens_ggplot2 <- ggplot(data = aliens,
                         aes(x = Year,
                             y = Removals)) +
  # Line plot basics
  geom_line(color = "black") +
  geom_point(color = "coral")
aliens_ggplot2


# plotly graph
aliens_plotly <- ggplotly(aliens_ggplot2)
aliens_plotly


# Returns
# ggplot2 graph
aliens1_ggplot2 <- ggplot(data = aliens,
                         aes(x = Year,
                             y = Returns)) +
  # Line plot basics
  geom_line(color = "black") +
  geom_point(color = "steelblue")
aliens1_ggplot2


# plotly graph
aliens1_plotly <- ggplotly(aliens1_ggplot2)
aliens1_plotly


## Posting this on plot.ly

Sys.setenv("plotly_username" = "jarrenls")
Sys.setenv("plotly_api_key" = "lnFjXP8NqcT1h08p59rb")

api_create(aliens_plotly, filename = "AlienRemovals")
api_create(aliens1_plotly, filename = "AlienReturns")