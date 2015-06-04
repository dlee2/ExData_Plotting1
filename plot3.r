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

#construct plot 3
datetime <- paste(subsettedData$Date, subsettedData$Time)
subsettedData$Datetime <- as.POSIXct(datetime)
subMetering1 <- as.numeric(subsettedData$Sub_metering_1)
subMetering2 <- as.numeric(subsettedData$Sub_metering_2)
subMetering3 <- as.numeric(subsettedData$Sub_metering_3)
png("household_power_consumption/plot3.png", height = 480, width = 480)
plot(subMetering1 ~ subsettedData$Datetime, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "black")
lines(subsettedData$Datetime,subMetering2, type = "l", col = "red")
lines(subsettedData$Datetime,subMetering3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()
