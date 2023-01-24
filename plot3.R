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

with(mysubset, plot(Date, Sub_metering_1, type = "n", xlab = "", ylab = ""))
with(mysubset, points(Date, Sub_metering_1, type = "l", col = "black"))
with(mysubset, points(Date, Sub_metering_2, type = "l", col = "red"))
with(mysubset, points(Date, Sub_metering_3, type = "l", col = "blue"))
title(ylab = "Energy sub metering")
legend("topright", lty="solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.copy(device = png, file = "./plot3.png")
dev.off()
