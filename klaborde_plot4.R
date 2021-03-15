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

power_consumption$Sub_metering_1 <- as.numeric(power_consumption$Sub_metering_1)
power_consumption$Sub_metering_2 <- as.numeric(power_consumption$Sub_metering_2)
power_consumption$Sub_metering_3 <- as.numeric(power_consumption$Sub_metering_3)
power_consumption$Voltage <- as.numeric(power_consumption$Voltage)

power_consumption$DateTime <- as.POSIXct(strptime(paste(power_consumption$Date,power_consumption$Time), "%d/%m/%Y %H:%M:%S"))



#plot 4
png(filename = "klaborde_plot4.png", 
    width=480, 
    height= 480,
    units = "px")

#plots en grilla
par(mfcol=c(2,2))

plot(power_consumption$DateTime, power_consumption$Global_active_power, 
     type= "l", lwd= 1,
     xlab="",
     ylab= "Global Active Power (kilowatts)")

plot(x=power_consumption$DateTime,y=power_consumption$Sub_metering_1,
     type= "l",
     xlab= "", 
     ylab= "Energy Sub Meetering")

lines(x= power_consumption$DateTime, 
      y= power_consumption$Sub_metering_2, 
      type= "l", col= "red")

lines(x= power_consumption$DateTime, 
      y= power_consumption$Sub_metering_3, 
      type= "l", col= "blue")

legend("topright",
       c("Sub Metering 1","Sub Metering 2", "Sub Metering 3"),
       lty= 1, bty="n", lwd= 2,
       col= c("black","red","blue"))

plot(x=power_consumption$DateTime,y=power_consumption$Voltage,
     type= "l",
     xlab= "datetime", ylab= "Voltage")

plot(x=power_consumption$DateTime,y=power_consumption$Global_reactive_power,
     type= "l",
     xlab= "datetime", ylab= "Global_reactive_power")


dev.off()

