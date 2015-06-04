#download the data and unzip it
if(!file.exists("household_power_consumption")){
  dir.create("household_power_consumption")
}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption/household_power_consumption.zip", method = "curl")
unzip("household_power_consumption/household_power_consumption.zip", exdir= "/Users/DanLee/household_power_consumption")

#read in the data
data <- read.table("household_power_consumption/household_power_consumption.txt", sep = ';', na.strings = '?', header = TRUE)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

subsettedData <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
rm(data)

#construct plot2
png("household_power_consumption/plot2.png", height = 480, width = 480)
datetime <- paste(subsettedData$Date, subsettedData$Time)
subsettedData$Datetime <- as.POSIXct(datetime)
subsettedData$Global_active_power <- as.numeric(subsettedData$Global_active_power)
with(subsettedData, plot(Global_active_power ~ Datetime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()
