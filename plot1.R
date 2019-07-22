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
feb_data$Global_active_power <- as.numeric(feb_data$Global_active_power) / 1000

par(mfcol=c(1,1))
png(filename = "plot1.png", width = 480, height = 480)
hist(feb_data$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
