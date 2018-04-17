gcd.zip <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "kWh.zip")
unzip("kWh.zip")
library(dplyr)
library(data.table)
library(lubridate)

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

## variables to correct classes
energy_data$Global_active_power <- as.numeric(energy_data$Global_active_power)
energy_data$Global_reactive_power <- as.numeric(energy_data$Global_reactive_power)
energy_data$Voltage <- as.numeric(energy_data$Voltage)
energy_data$Sub_metering_1 <- as.numeric(energy_data$Sub_metering_1)
energy_data$Sub_metering_2 <- as.numeric(energy_data$Sub_metering_2)
energy_data$Sub_metering_3 <- as.numeric(energy_data$Sub_metering_3)

energy_data <- select(energy_data, Date, Global_active_power, Global_reactive_power, Voltage, Sub_metering_1, Sub_metering_2, Sub_metering_3)

## rename Date to datetime per assignment instructions

names(energy_data)[names(energy_data) == 'Date'] <- 'datetime'

## plot 4 graphs in a 2 x 2 

par(mfrow = c(2, 2))

with(energy_data, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

with(energy_data, plot(datetime, Voltage, type = "l"))

with(energy_data, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(energy_data, lines(datetime, Sub_metering_2, col = "Red"))
with(energy_data,lines(datetime, Sub_metering_3, col = "Blue"))

with(energy_data, legend("topright",  lty = 1, lwd = 2,
                         cex=.8, xjust = 1, yjust = 1, col = c("black", "red", "blue"),bty = "n", 
                         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")))

with(energy_data, plot(datetime, Global_reactive_power, type = "l"))

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()

