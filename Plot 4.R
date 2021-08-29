Author: H.Snit
Date : 28/08/2021


##Import data 
getwd()
data <-read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
head(data)
library(dplyr)


class(data$Date)
##[1] "character"
data$Date <- as.Date(data$Date,format="%d/%m/%Y")
class(data$Date)
#[1] "Date"

## Select date from 2007-02-01 to 2007-02-02
start_date <- ("2007-02-01")## Start date
end_date <- ("2007-02-02")  ## End date


## Create new data set filtered according to Date
data2 <- data[which(data$Date >= start_date &    
                      data$Date <= end_date),]


## Make Global active power numeric
data2$Global_active_power <- as.numeric(data2$Global_active_power,dec=3)

## Create new column with weekdays
data2$Day <- weekdays(data2$Date)
## Set day as factor
data2$Day <- as.factor(data2$Day)
## Create combined DateTime column
data2$DateTime <- paste(data2$Date,data2$Time)
data2$DateTime <- as.POSIXct(data2$DateTime)


## Create 2 x 2 plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
Plot4 <- with(data2, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty="n",   ## Create legends
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Create plot 4 as png file, width = 480, height = 480
dev.copy(png,"Plot4.png",width = 480,height = 480)
Plot4
dev.off()