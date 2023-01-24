# download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("household_power_consumption.txt")){
    download.file(fileUrl, destfile = "Housegold_power_consumption.zip")
    unzip("Housegold_power_consumption.zip")
}

# Loading data into R and changing date and time variables
mydata <- read.table("./household_power_consumption.txt", 
                     sep = ";",
                     header = TRUE, 
                     na.strings = "?")
mydata$Date <- strptime(paste(mydata$Date, mydata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
mydata$Time <- NULL

# Subsetting data
mysubset <- subset(mydata, mydata$Date >= "2007-02-01" & mydata$Date < "2007-02-03" )

# Graph creation

par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))
# 1
with(mysubset, plot(Date, Global_active_power, 
                    type = "l", xlab="", 
                    ylab = "Global Active Power"))
# 2
with(mysubset, plot(Date, Voltage, 
                    type = "l", xlab="", 
                    ylab = "Voltage"))
# 3
with(mysubset, plot(Date, Sub_metering_1, type = "n", xlab = "", ylab = ""))
with(mysubset, points(Date, Sub_metering_1, type = "l", col = "black"))
with(mysubset, points(Date, Sub_metering_2, type = "l", col = "red"))
with(mysubset, points(Date, Sub_metering_3, type = "l", col = "blue"))
title(ylab = "Energy sub metering")
legend("topright", lty="solid", col = c("black", "red", "blue"), box.lwd = 0, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# 4
with(mysubset, plot(Date, Global_reactive_power, 
                    type = "l", xlab="", 
                    ylab = "Global reactive power"))


dev.copy(device = png, file = "./plot4.png")
dev.off()
