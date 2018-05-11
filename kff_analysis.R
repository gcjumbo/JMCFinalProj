
## Setup (libraries, data, etc.)

# Set directory to location w/ aliens 
setwd("~/Documents/The University of Iowa/Spring 2018/JMC-3640/Final Project")

# Load data into R
# Original: https://www.kff.org/other/state-indicator/total-population/?dataView=0&currentTimeframe=0&sortModel=%7B%22colId%22:%22Employer%22,%22sort%22:%22asc%22%7D
kff <- read.csv("~/Documents/The University of Iowa/Spring 2018/JMC-3640/Final Project/kff_hi.csv", na.strings="N/A")

# Load necessary libraries
library(ggplot2)
#devtools::install_github('hadley/ggplot2')
library(plotly)



## Cleaning Data

# We only want to show the top three states mentioned in the article
kff.usethis <- kff[1:10, ]
kff.usethis <- kff[order(kff.usethis$Medicaid), ]

# Set scale based on values
states <- factor(c("New Mexico", "West Virginia", "Louisiana",
            "California", "Oregon", "New York", "Mississippi",
            "District of Columbia", "Massachusetts", "Delaware"))



## Plot cool stuff

# Medicaid
# ggplot2 graph
kff_ggplot2 <- ggplot(data = kff.usethis, 
                      aes(x = as.character(Location),
                          y = Medicaid*100)) +
  # Bar plot basics
  geom_bar(stat = "identity", color = "black", fill = "palegoldenrod") +
  
  # Aesthetics
  # coord_flip() + 
  scale_x_discrete(limits = states) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  
  # Titles and labels
  xlab("State") +
  ylab("% Covered by Medicaid & CHIP")
kff_ggplot2

# plotly graph
kff_plotly <- ggplotly(kff_ggplot2)
kff_plotly



## Other plots

# Employer-based Insurance
kff1 <- ggplot(data = kff,
               aes(x = Location,
                   y = Employer)) +
  geom_bar(stat = "identity", color = "black", fill = "firebrick") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
kff1
  
kff1_plotly <- ggplotly(kff1)
kff1_plotly

# Medicare
kff2 <- ggplot(data = kff,
               aes(x = Location,
                   y = Medicare)) +
  geom_bar(stat = "identity", color = "black", fill = "azure") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
kff2

kff2_plotly <- ggplotly(kff2)
kff2_plotly

# Uninsured
kff3 <- ggplot(data = kff,
               aes(x = Location,
                   y = Uninsured)) +
  geom_bar(stat = "identity", color = "black", fill = "mediumpurple") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
kff3

kff3_plotly <- ggplotly(kff3)
kff3_plotly


## Posting this on plot.ly

Sys.setenv("plotly_username" = "jarrenls")
Sys.setenv("plotly_api_key" = "lnFjXP8NqcT1h08p59rb")

api_create(kff_plotly, filename = "KFF Medicaid")
api_create(kff1_plotly, filename = "KFF Employer")
api_create(kff2_plotly, filename = "KFF Medicare")
api_create(kff3_plotly, filename = "KFF Uninsured")