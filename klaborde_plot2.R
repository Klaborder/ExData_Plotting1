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
power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)

#subset
power_consumption <- power_consumption %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")

power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)

power_consumption$DateTime <- as.POSIXct(strptime(paste(power_consumption$Date,power_consumption$Time), "%d/%m/%Y %H:%M:%S"))



#plot 2
png(filename = "klaborde_plot2.png", 
    width=480, 
    height= 480,
    units = "px")

plot(power_consumption$DateTime, power_consumption$Global_active_power, 
     type= "l", 
     xlab="",
     ylab= "Global Active Power (kilowatts)")

dev.off()

