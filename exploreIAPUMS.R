
## Set directory to location w/ IA PUMS
setwd("/Users/jarrenLS/Documents/The University of Iowa/Spring 2018/JMC-3640/Final Project")

## Load data into R
iapums08 <- read.csv("csv_pia2008-12/ss12pia.csv")    # 2008-2012 5-Year PUMS
iapums12 <- read.csv("csv_pia2012-16/ss16pia.csv")    # 2012-2016 5-Year PUMS

## Link to interactive map that shows PUMA boundaries
# https://usa.ipums.org/usa/volii/2010PUMAS.shtml

## Counties included in PUMAs (** = PUMA ratio is greater than statewide ratio)
# PUMAs - https://usa.ipums.org/usa/volii/2010PUMAS.shtml
# 00100 - Sioux, Clay, Dickinson, O'Brien, Lyon, Emmet, Palo Alto & Osceola
# 00200 - Cerro Gordo, Floyd, Kossuth, Hancock, Winnebago, Mitchell & Worth
# 00400 - Bremer, Winneshiek, Fayette, Clayton, Allamakee, Chickasaw & Howard
# ** 00500 - Black Hawk County--Waterloo & Cedar Falls
# 00600 - Webster, Hardin, Hamilton, Butler, Wright, Grundy, Franklin & Humboldt
# 00700 - Dubuque, Buchanan, Jackson & Delaware Counties--Dubuque
# 00800 - Clinton, Muscatine, Jones & Cedar
# ** 00900 - Scott County--Davenport
# 01000 - Linn County--Cedar Rapids
# ** 01100 - Johnson County--Iowa City
# ** 01200 - Marshall, Benton, Poweshiek, Tama & Iowa
# ** 01300 - Story & Boone Counties--Ames 
# 01400 - Warren, Jasper, Marion, Dallas (West) & Madison 
# ** 01500 - Polk (Southwest) & Dallas (East) Counties--West Des Moines & Urbandale
# 01600 - Polk County (East)--Ankeny & Altoona
# ** 01700 - --Des Moines
# 01800 - South Central 
# 01900 - Northwest Central Iowa--Storm Lake, Denison & Cherokee
# ** 02000 - Woodbury & Plymouth Counties--Sioux City
# 02100 - Southwest Iowa--Council Bluffs
# ** 02200 - Wapello, Mahaska, Washington, Jefferson, Keokuk, Davis & Van Buren
# 02300 - Des Moines, Lee, Henry & Louisa 

## Vars of interest (referenced from respective data dictionary): 
# iapums08 - "CIT", "CITWP05", "CITWP12", "FCITP", "FCITWP"
# iapums12 - "CIT", "CITWP", "FCITP", "FCITWP" 

keep.iapums08 <- c("PUMA10", "CIT", "CITWP05", "CITWP12", "FCITP", "FCITWP")
keep.iapums12 <- c("PUMA", "CIT", "CITWP", "FCITP", "FCITWP")

ia08 <- iapums08[, keep.iapums08]
ia12 <- iapums12[, keep.iapums12]

# Create is.citizen var to indicate whether a person is a citizen
ia08$is.citizen <- ifelse(ia08$CIT == 5, 0, 1)
ia12$is.citizen <- ifelse(ia12$CIT == 5, 0, 1)

# Ratio compares non-citizen to citizen (ie. 0.018 non-citizens for ea. citizen)
tableCitizenship <- table(ia12$is.citizen)
allCitizenRatio <- (tableCitizenship[1] / tableCitizenship[2])
names(allCitizenRatio) <- NULL

tablePUMAvsCitizen <- table(ia12$PUMA, ia12$is.citizen)
PUMAvsCitizenRatios <- (tablePUMAvsCitizen[, 1] / tablePUMAvsCitizen[, 2])
PUMAvsCitizenRatios[which(PUMAvsCitizenRatios > allCitizenRatio)]

write.csv(tablePUMAvsCitizen, "PUMACitizenshiptable.csv")
