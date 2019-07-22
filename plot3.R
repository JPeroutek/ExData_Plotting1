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

par(mfcol=c(1,1))
png(filename = "plot3.png", width = 480, height = 480)
plot(feb_data$DateTime, feb_data$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering", col = "black")
lines(feb_data$DateTime, feb_data$Sub_metering_2, type = "l", col = "red")
lines(feb_data$DateTime, feb_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 1)
dev.off()