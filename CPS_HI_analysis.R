
## Setup (libraries, data, etc.)

# Set directory to location w/ IA PUMS
setwd("/Users/jarrenLS/Documents/The University of Iowa/Spring 2018/JMC-3640/Final Project")

# Load data into R
# Original: https://www.census.gov/data/tables/time-series/demo/income-poverty/cps-hi/hi-09.2010.html
cps_hi <- read.csv("CPS_HI_2011-2016.csv")

# Load necessary libraries
library(ggplot2)
#devtools::install_github('hadley/ggplot2')
library(plotly)



## Data Manipulations

# Change year from numeric to char var
cps_hi$year <- as.character(cps_hi$year)

# Calculate percentages for scale

# Perc population represented by specific citizenship
cps_hi$percPopRep <- 100 * (cps_hi$totalPersons / cps_hi$yearTot)
# Perc population not covered with health insurance
cps_hi$percNotCov <- 100 * (cps_hi$notCovered / cps_hi$totalPersons)
# Perc population covered by gov health ins
cps_hi$percGovHI <- 100 * (cps_hi$totalGovHI / cps_hi$totalPersons)
# Perc population covered by Medicaid given coverage by gov health ins
cps_hi$percMedicaid <- 100 * (cps_hi$insuredMedicaid / cps_hi$totalGovHI)



## Plot cool stuff

# ggplot2 graph
medicaid_ggplot2 <- ggplot(data = cps_hi, 
                           aes(x = year, y = percMedicaid, 
                               fill = citizenship)) +
  # Bar graph information
  geom_bar(stat = "identity", color = "black", position = position_dodge()) +
  
  # Aesthetics
  #scale_fill_manual(values = c("red", "blue", "green")) +
  scale_fill_brewer(palette = "Set1") +
  ylim(c(0, 100)) +
  
  # Titles and labels
  ggtitle("Pop. Covered by Govt. Health Insurance via Medicaid 2011-16") +
  xlab("Year") +
  ylab("Pop. Covered (%)") +
  theme_light() +
  
  # Legend options
  theme(legend.title = element_blank(),
        legend.position = "bottom")
medicaid_ggplot2

# plotly graph
medicaid_plotly <- ggplotly(medicaid_ggplot2)
medicaid_plotly
