library(lubridate)
library(dplyr)

file.Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("./data")) {
        dir.create("./data")
}

download.file(file.Url, destfile="./data/zipFile.zip")

unzip("./data/zipFile.zip", exdir="./data")

hhData<-read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")

hhData$Date<-as.Date(dmy(hhData$Date))

subset<-filter(hhData, Date == '2007-02-01' | Date == '2007-02-02' )
subset$DateTime<-strptime(paste(subset$Date, subset$Time), format = "%Y-%m-%d %H:%M:%S")

png("plot3.png")
with(subset, plot(DateTime, Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering"))
with(subset, points(DateTime, Sub_metering_1, col = "Black", type = "l"))
with(subset, points(DateTime, Sub_metering_2, col = "Red", type = "l"))
with(subset, points(DateTime, Sub_metering_3, col = "Blue", type = "l"))

legend("topright", lty=c(1,1,1), col=c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
