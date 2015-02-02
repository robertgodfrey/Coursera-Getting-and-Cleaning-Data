# Quiz 4. Question 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# get data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
dest <- "C:\\Users\\Robert\\Documents\\Coursera_GettingandCleaningData\\quiz4\\communitydata.csv"
download.file(url, dest)

# get to work
setwd("C:\\Users\\Robert\\Documents\\Coursera_GettingandCleaningData\\quiz4")

com <- read.csv(dest)
names <- names(com)
split.names <- strsplit(names, "wgtp")
answer <- split.names[123]
# answer
# [[1]]
# [1] ""   "15"

# Cleanup workspace
rm(list=ls())

# Quiz 4. Question 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# get data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
dest <- "C:\\Users\\Robert\\Documents\\Coursera_GettingandCleaningData\\quiz4\\gdp.csv"
download.file(url, dest)

gdp <- read.csv(dest)

# subset gdp data, remove commas, make numeric again
clean.gdp <- as.numeric(gsub(",", "", gdp[5:194, 5]))

answer <- mean(clean.gdp)
# [1] 377652.4

# Cleanup workspace
rm(list=ls())

# Quiz 4. Question 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# get data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
dest <- "C:\\Users\\Robert\\Documents\\Coursera_GettingandCleaningData\\quiz4\\gdp.csv"
download.file(url, dest)

gdp <- read.csv(dest)

# subset the country name column
countryNames <- gdp[5:194,4]

answer <- length(grep("^United", countryNames))
# [1] 3

# Cleanup workspace
rm(list=ls())

# Quiz 4. Question 4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# get gdp data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
dest <- "C:\\Users\\Robert\\Documents\\Coursera_GettingandCleaningData\\quiz4\\gdp.csv"
download.file(url, dest)
gdp <- read.csv(dest)

# get educational data
ed.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
ed.dest <- "C:\\Users\\Robert\\Documents\\Coursera_GettingandCleaningData\\quiz4\\ed.csv"
download.file(ed.url, ed.dest)
ed <- read.csv(ed.dest)

View(gdp)
View(ed)

# after looking at data, there is no need to merge datasets
answer <- length(grep("Fiscal year end: June", ed[,10]))
# [1] 13

# Cleanup workspace
rm(list=ls())

# Quiz 4. Question 4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
install.packages("quantmod")
library(quantmod)
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn) 

View(sampleTimes)

# part 1
answer1 <- length(grep("^2012", sampleTimes))
# [1] 250

# part 2
# subset by year 2012
data.2012 <- subset(sampleTimes, as.numeric(format(sampleTimes, "%Y")) == 2012)

# get number of Mondays in 2012
answer2 <- length(weekdays(data.2012) == "Monday")
# [1] 47

