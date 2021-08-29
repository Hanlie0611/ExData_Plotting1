Author: H.Snit
Date : 28/08/2021

## 1] Calculate memory requirements before importing data

yrows <- 2075259 ##  Number of Rows
xcol <- 9        ## Number of Columns
mem <- yrows*xcol*8    ##  Number of Bytes
result <- mem/2^20    ##  Number of Mb to read the data
result ### Print the result [142.5Mb]


## 2] Import data 
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
## Create Plot 1 = Red histogram of Global active power with headings
par(mfrow=c(1,1), mar=c(4,4,2,1), oma=c(0,0,2,0))
Plot1 <- hist(data2$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowats)")

## Create png file, png width=480, height=480
dev.copy(png,"Plot1.png", width=480, height=480)
Plot1
dev.off()

