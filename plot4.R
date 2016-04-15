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
png("plot4.png", width = 480, height = 480)
# prepare for 4 plots, add each plot column-wise
par(mfcol = c(2,2))
# sub plot 1
plot(Global_active_power~datePlusTimes, data = data2Days, type="l", ylab="Global Active Power", xlab = "")

# sub plot 2
#plot Sub_metering_1
with(data2Days, plot(data2Days$datePlusTimes, data2Days$Sub_metering_1,  type = "l", ylab = "Energy sub metering", xlab = ""))
#add to the plot : Sub_metering_2
lines(data2Days$datePlusTimes, data2Days$Sub_metering_2, col="red")
#add to the plot : Sub_metering_3
lines(data2Days$datePlusTimes, data2Days$Sub_metering_3, col="blue")
# add a legend
legend( x="topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("black", "red","blue"), lty = c(1, 1, 1), bty = "n")

# sub plot 3
plot(Voltage ~ datePlusTimes, data = data2Days, type="l", xlab = "datetime", ylab="Voltage")

# sub plot 4
plot(Global_reactive_power ~ datePlusTimes, data = data2Days, type="l", xlab = "datetime", ylab="Global_reactive_power")

# close the file
dev.off()