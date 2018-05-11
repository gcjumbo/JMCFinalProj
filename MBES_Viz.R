
## Setup (libraries, data, etc.)

# Set directory to location w/ IA PUMS
setwd("C:/Users/Jarren Santos/Desktop/JMC Final Proj")

# Load data into R
# Original: https://www.medicaid.gov/medicaid/program-information/medicaid-and-chip-enrollment-data/enrollment-mbes/index.html
mbes <- read.csv("C:/Users/Jarren Santos/Desktop/JMC Final Proj/2016_4Q_Medicaid_MBES_Enrollment.csv")

# Load necessary libraries
library(ggplot2)
#devtools::install_github('hadley/ggplot2')
library(plotly)



## Cleaning Data

# Get rid of any rows that include "Totals"
mbes <- mbes[mbes$State != "Totals", ]

# Select most recent data for visualization (enrollment.month = 12)
mbes.viz <- mbes[mbes$Enrollment.Month == 12, ]

# Sort states in alphabetical order
mbes.viz <- mbes.viz[order(mbes.viz$Total.Medicaid.Enrollees, 
                           decreasing = TRUE), ]

# Long data (???)
mbes.long <- melt(mbes.viz, id.vars = "State")
mbes.long$value <- as.numeric(mbes.long$value)
mbes.long <- mbes.long[mbes.long$variable %in% c("Total.Medicaid.Enrollees",
                                                 "Total.VIII.Group.Enrollees",
                                                 "Total.VIII.Group.Newly.Eligible.Enrollees",
                                                 "Total.VIII.Group.Not.Newly.Eligible.Enrollees"), ]
mbes.usethis <-  mbes.long[mbes.long$variable %in% c("Total.Medicaid.Enrollees",
                                                     "Total.VIII.Group.Enrollees"), ]
                           #& is.na(mbes.long$value) != TRUE, ]




## Visualizing Data

# Plot
mbes.total_ggplot2 <- ggplot(data = mbes.usethis,
                             aes(x = State, y = value, fill = variable)) +
  # Bar graph information
  geom_bar(stat = "identity", color = "black", position = position_dodge()) +
  # Aesthetics
  scale_fill_brewer(palette = "Set1") + 
  guides(color = guide_legend(nrow = ))
mbes.total_ggplot2

mbes.expand_ggplot2
mbes.expand_ggplot2





