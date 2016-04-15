#read in all data
allData <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
# create new column of date Variables to Date type
allData$dates <- as.Date(allData$Date, "%d/%m/%Y")
# remove old row
allData$Date <- NULL
# use data within 2 dates
data2Days <- subset(allData, ((allData$dates >= as.Date("2007-02-01")) & (allData$dates <= as.Date("2007-02-02"))))
# another way : data2Days <- allData[((allData$dates >= as.Date("2007-02-01")) & (allData$dates <= as.Date("2007-02-02"))), ]
# delete the variable "allData"
rm(allData)

# create a vector by concatenating date+time column variables
datePlusTime <- paste(as.Date(data2Days$dates), data2Days$Time)
# create a new column of type dateTime
data2Days$datePlusTimes <- as.POSIXct(datePlusTime)
# open a png file to write to
png("plot2.png", width = 480, height = 480)
# plot Global_active_power by datePlusTimes, make it "continuous" by connecting lines
plot(Global_active_power~datePlusTimes, data = data2Days, type="l", ylab = "Global Active Power(kilowatts)", xlab = "")
# close the file
dev.off()