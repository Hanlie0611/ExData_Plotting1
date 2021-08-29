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

## Import data from 2007-02-01 to 2007-02-02
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
## Create PLot 2, Line plot of Global Active POwer against DateTime Column
Plot2 <- with(data2, {
  plot(Global_active_power~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="", lwd=2)
})

## Save Plot 2 as png file, width = 480, height = 480
dev.copy(png,"Plot2.png",width = 480,height = 480)
Plot2
dev.off()