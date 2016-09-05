
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

# read data into R
files <- file('./data/household_power_consumption.txt')
data <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')


#3- Create/Plot Graph Plot 3

# open device

png(filename = './plot3.png', width = 480, height = 480, units='px')
# plot figure
Sys.setlocale(category = "LC_ALL", locale = "english")
plot(data$DateTime, data$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l')
lines(data$DateTime, data$Sub_metering_2, col = 'red')
lines(data$DateTime, data$Sub_metering_3, col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)
# close device
dev.off()
