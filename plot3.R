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

energy_data$Sub_metering_1 <- as.numeric(energy_data$Sub_metering_1)
energy_data$Sub_metering_2 <- as.numeric(energy_data$Sub_metering_2)
energy_data$Sub_metering_3 <- as.numeric(energy_data$Sub_metering_3)

energy_data <- select(energy_data, Date, Sub_metering_1, Sub_metering_2, Sub_metering_3)


png("plot3.png", width=480, height=480)
attach(energy_data)
plot(Sub_metering_1 ~ Date, type = "l", 
     ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2 ~ Date, col = "Red")
lines(Sub_metering_3 ~ Date, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
