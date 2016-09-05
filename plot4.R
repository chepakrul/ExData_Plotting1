
#1 - Set path (My path is E:/JHU/Course4/Week1/Project")
---------------------------------------------------
setwd("E:/JHU/Course4/Week1/Project")
getwd()


#"E:/JHU/Course4/Week1/Project"

#2 - Get the data
#------------

# download and unzip data
if(!file.exists('data')) dir.create('data')
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./data/household_power_consumption.zip"

zipfile <- "./data/household_power_consumption.zip"
download.file(fileUrl, destfile, method = "curl")
unzip(zipfile, exdir = "./data")

#3- Create Graph Plot 4
# Load SQL library in order to filter the data set
library(sqldf)

# Load filtered data from the data file
ds <- read.csv.sql(file = "./data/household_power_consumption.txt", sep = ";", header = TRUE , sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'")

# Change column data type to numeric
ds$dt  <- strptime(paste(ds$Date, ds$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
ds$gap <- as.numeric(ds$Global_active_power)
ds$grp <- as.numeric(ds$Global_reactive_power)
ds$vol <- as.numeric(ds$Voltage)
ds$sm1 <- as.numeric(ds$Sub_metering_1)
ds$sm2 <- as.numeric(ds$Sub_metering_2)
ds$sm3 <- as.numeric(ds$Sub_metering_3)

# Create PNG graphic device
png("plot4.png", width=480, height=480)

# Generate graph
par(mfrow = c(2,2))

with(ds, plot(dt, gap, type="l", xlab="", ylab="Global Active Power (kilowatts)", cex=0.2))
with(ds, plot(dt, vol, type="l", xlab="datetime", ylab="Voltage"))
with(ds, plot(dt, sm1, type="l", ylab="Energy Submetering", xlab=""))
with(ds, lines(dt, sm2, type="l", col="red"))
with(ds, lines(dt, sm3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
with(ds, plot(dt, grp, type="l", xlab="datetime", ylab="Global_reactive_power"))

# Reset the device
dev.off()