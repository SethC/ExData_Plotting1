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

hist(subset$Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)", col = "Red" )

dev.copy(png, file = "plot1.png")
dev.off()

