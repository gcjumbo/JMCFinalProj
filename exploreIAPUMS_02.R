
## Load data and libraries

# library(readr)
# library(plotly)

iowaCitizenship <- read.csv("PUMACitizenshiptable.csv", header = TRUE)
names(iowaCitizenship) <- c("puma", "0", "1")
iowaCitizenship$puma <- as.character(iowaCitizenship$puma)
iowaCitizenship$puma <- ifelse(nchar(iowaCitizenship$puma) < 4,
                               paste0("0", iowaCitizenship$puma),
                               iowaCitizenship$puma)

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

## 



