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

# open a png file to write to
png("plot1.png", width = 480, height = 480)
hist(data2Days$Global_active_power, col = "red", xlab = "Global Active Power(kilowatts)", main = "Global Active Power")
# close the file
dev.off()