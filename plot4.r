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

#construct plot 4
datetime <- paste(subsettedData$Date, subsettedData$Time)
subsettedData$Datetime <- as.POSIXct(datetime)
subsettedData$Voltage <- as.numeric(subsettedData$Voltage)
subsettedData$Global_active_power <- as.numeric(subsettedData$Global_active_power)
subsettedData$Global_reactive_power <- as.numeric(subsettedData$Global_reactive_power)

png("household_power_consumption/plot4.png", height = 480, width = 480)
par(mfrow=c(2,2))
#top left plot
with(subsettedData, plot(Datetime, Global_active_power, type= "l", xlab = "", ylab = "Global Active Power"))

#top right plot
with(subsettedData, plot(Datetime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

#bottom left plot
with(subsettedData, plot(subMetering1 ~ Datetime, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "black"))
lines(subMetering2~subsettedData$Datetime, type = "l", col = "red")
lines(subMetering3~subsettedData$Datetime, type = "l", col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#bottom right plot
with(subsettedData, plot(Datetime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l", bty = "o"))

dev.off()
