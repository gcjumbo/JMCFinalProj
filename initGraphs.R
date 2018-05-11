
## Load necessary libraries and data
setwd("C:/Users/Jarren Santos/Desktop/JMC Final Proj")

library(readr)
library(plotly)

iowaCitizenship <- read_csv("PUMACitizenshiptable.csv")
iowaCitizenship$puma <- as.character(iowaCitizenship$puma)
iowaCitizenship$puma <- ifelse(nchar(iowaCitizenship$puma) < 4,
                               paste0("0", iowaCitizenship$puma),
                               iowaCitizenship$puma)

nonimmigranti94 <- read_csv("nonimmigrantAdmitsI94.csv")
nonimmigranti94 <- nonimmigranti94[nonimmigranti94$destination != "Total", ]
  
refugeeArrivals <- read_csv("refugeeArrivals.csv")





## Initial graphs

# Comparison of U.S. Citizens and non-U.S. Citizens within Iowa
# Based on PUMS 2012-2016 ACS Data

# Data-preprocessing
totalNotUS <- sum(iowaCitizenship$`0`)
totalUS <- sum(iowaCitizenship$`1`)
totalCitiRatio <- totalNotUS / totalUS
iowaCitizenship$percNotUS <- iowaCitizenship$`0` / totalNotUS
iowaCitizenship$percUS <- iowaCitizenship$`1` / totalUS
iowaCitizenship$citiRatio <- iowaCitizenship$`0` / iowaCitizenship$`1`
iowaCitizenship$puma <- factor(iowaCitizenship$puma,
                               levels = unique(iowaCitizenship$puma)[order(iowaCitizenship$percNotUS,
                                                                     decreasing = TRUE)])
citiData <- iowaCitizenship[order(iowaCitizenship$percNotUS, 
                                  decreasing = TRUE), ]
citiData <- citiData[1:10, ]

# Plot
citizenshipIowa <- plot_ly(citiData, x = ~puma, y = ~percNotUS, 
                           name = "Not U.S. Citizen",
                           type = "bar") %>%
  add_trace(y = ~percUS, name = "U.S. Citizen") %>%
  layout(title = "Iowan Citizenship Comparison Between PUMAs",
         xaxis = list(title = "ACS-Defined Area", 
                      tickangle = 0),
         yaxis = list(title = "Percent Makeup"), barmode = "stack")
citizenshipIowa


# Nonimmigrant Admissions (I-94) by Admission and Destination FY 2016
# https://www.dhs.gov/immigration-statistics/yearbook/2016/table30

# Data-preprocessing
nonimmigranti94$destination <- factor(nonimmigranti94$destination, 
                                      levels = unique(nonimmigranti94$destination)[order(nonimmigranti94$total,
                                                                                         decreasing = TRUE)])
i94data <- nonimmigranti94[order(nonimmigranti94$total,
                                 decreasing = TRUE), ]
i94data <- i94data[1:11, ]

# Plot
i94Admits <- plot_ly(i94data, x = ~destination, y = ~total,
                     type = "bar") %>%
  layout(title = "Top 10 Highest Total Number of I-94 Admissions by Destination",
         xaxis = list(title = "Destination",
                      tickangle = 20),
         yaxis = list(title = "Total"))
i94Admits

# Refugee Arrivals
# https://www.dhs.gov/immigration-statistics/yearbook/2016/table13

# Plot
refugees <- plot_ly(refugeeArrivals, x = ~Year, y = ~Number, 
                    type = "scatter", mode = "lines",
                    line = list(color = "red")) %>%
  layout(title = "Refugee Arrivals for FY 1980 to 2016")
refugees


## Putting plots online (DO NOT GIVE THIS INFORMATION OUT)

# Save authentication credentials
Sys.setenv("plotly_username" = "jarrenls")
Sys.setenv("plotly_api_key" = "lnFjXP8NqcT1h08p59rb")

# Publish graphs onto plotly

api_create(citizenshipIowa, filename = "citizenshipIowa")
api_create(i94Admits, filename = "i94Admits")
api_create(refugees, filename = "refugeeArrivals")
