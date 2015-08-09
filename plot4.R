## 1.Download the zipped data file and place it into the data folder 
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/exdata_data_household_power_consumption.zip", method="curl")

## 2.Unzip the file
unzip(zipfile="./data/exdata_data_household_power_consumption.zip", exdir="./data")

## 3.Get file path
path_rf <- file.path("./data", "household_power_consumption.txt")

## 4.Read all data
data <- read.table(path_rf, header = TRUE, sep = ";")

## 5.Subset only data from 2007-02-01 and 2007-02-02
data2 <- data[as.character(data$Date) %in% c("1/2/2007", "2/2/2007"),]

## 6.Create a new colume by combining both date and time
data2$dateTime = paste(data2$Date, data2$Time)

## 7.Convert Date and Time variables to Date/Time classes. 
data2$dateTime <- strptime(data2$dateTime, "%d/%m/%Y %H:%M:%S")

## 8.Plot graph
png("plot4.png", width=480, height=480, units="px")
#set matrix 2x2
par(mfrow=c(2,2))
#plot (1,1)
plot(data2$dateTime, as.numeric(as.character(data2$Global_active_power)), type="l", xlab="", ylab="Global Active Power")
#plot (2,1)
plot(data2$dateTime, as.numeric(as.character(data2$Voltage)), type="l", xlab="datetime", ylab="Voltage")
#plot (1,2)
plot(data2$dateTime, as.numeric(as.character(data2$Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40))
lines(data2$dateTime, as.numeric(as.character(data2$Sub_metering_2)), col="red")
lines(data2$dateTime, as.numeric(as.character(data2$Sub_metering_3)), col="blue")
legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
#plot (2,2)
plot(data2$dateTime, as.numeric(as.character(data2$Global_reactive_power)), type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()