gcd.zip <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "kWh.zip")
unzip("kWh.zip")
library(dplyr)
library(data.table)

## read data files from home directory

setwd("~/Documents/ContImprove/Exploratory Data Analysis")

## read in the desired variable names
energy_data_hdr <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 1)

## read in the desired rows
energy_data <- read.table(file = "household_power_consumption.txt", header = FALSE, 
                          sep = ";",na.strings = "?", stringsAsFactors = FALSE, skip = 66637, nrows = 2880) 

colnames(energy_data) <- colnames(energy_data_hdr)

## put Date and Time variables to Date/Time class
energy_data$Date <- paste(energy_data$Date, energy_data$Time)
energy_data$Date = as.POSIXct(dmy_hms(energy_data$Date))

energy_data$Global_active_power <- as.numeric(energy_data$Global_active_power)

energy_data <- select(energy_data, Date, Global_active_power)


# create plot
png("plot2.png", width=480, height=480)
with(energy_data, plot(Date, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

