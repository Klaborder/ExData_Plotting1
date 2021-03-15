#Author: Karina Laborde

library(lubridate)
library(dplyr)


#download data
urldata <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(urldata, destfile = "datasets/datapower_consumption.zip", mode = "wb")
unzip("datasets/datapower_consumption.zip", exdir = "datasets")

#read data
power_consumption <- read.table("datasets/household_power_consumption.txt", sep=";", header=TRUE)
head(power_consumption)
summary(power_consumption)

#subset
power_consumption <- power_consumption %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")

power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)


#plot 1

png(filename = "klaborde_plot1.png", 
    width=480, 
    height= 480,
    units = "px")

hist(power_consumption$Global_active_power, col= "red", 
     main= "Global Active Power",
     xlab= "Global Active Power (kilowatts)", 
     ylab= "Frequency",
     cex.main=0.9,
     cex.lab=0.7,
     cex.axis=0.6)

dev.off()


