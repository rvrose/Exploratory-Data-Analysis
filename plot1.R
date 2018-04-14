gcd.zip <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "kWh.zip")
unzip("kWh.zip")
library(dplyr)
library(data.table)

## read data files from home directory

setwd("~/Documents/ContImprove/Exploratory Data Analysis")

## read in the desired rows
energy_data <- read.table(file = "household_power_consumption.txt", header = FALSE, 
                         sep = ";",na.strings = "?", stringsAsFactors = FALSE, skip = 66637, nrows = 2880) 

## plot histogram
png("plot1.png", width=480, height=480)
hist(energy_data$V3, col = "red", main = "Global Active Power", xlab = "Gobal Active Power (kilowatts)", ylab = "Frequency")
dev.off()
