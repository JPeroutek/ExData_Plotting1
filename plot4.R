# Download and extract the raw data.
raw_archive <- "raw.zip"
if(!file.exists('household_power_consumption.txt')) {
  if(!file.exists('raw.zip')) {
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile = raw_archive, method = "curl")
  }
  unzip(raw_archive)
}

# Read in the data file
power_data <- read.table('household_power_consumption.txt', sep=";", header = TRUE)

# Transform and plot the data.
feb_data <- subset(power_data, Date %in% c("1/2/2007", "2/2/2007"))
feb_data$DateTime <- as.POSIXct(paste(feb_data$Date, feb_data$Time), format="%d/%m/%Y %X")
feb_data$Global_active_power <- as.numeric(feb_data$Global_active_power)
feb_data$Global_reactive_power <- as.numeric(feb_data$Global_reactive_power)

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))

# First plot
plot(feb_data$DateTime, feb_data$Global_active_power / 1000, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
# Second Plot
plot(feb_data$DateTime, feb_data$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering", col = "black")
lines(feb_data$DateTime, feb_data$Sub_metering_2, type = "l", col = "red")
lines(feb_data$DateTime, feb_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 1)
# Third Plot
plot(feb_data$DateTime, feb_data$Voltage, type="l", xlab="datetime", ylab="Voltage")
# Fourth Plot
plot(feb_data$DateTime, feb_data$Global_reactive_power / 1000, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()