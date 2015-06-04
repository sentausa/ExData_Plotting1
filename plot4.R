#Downloading the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "household_power_consumption.zip"
download.file(fileUrl, destination, method = "curl") ##I am using Mac, thus method = "curl"

#Creating the dataframe
header <- read.table(unz(destination, "household_power_consumption.txt"), sep = ";", header = TRUE, nrow = 1) ##to get the column names
data <- read.table(unz(destination, "household_power_consumption.txt"), col.names = names(header), sep = ";", skip = 66637, nrows = 2879, na.strings = "?")

#Installing and loading lubridate for date formatting
install.packages("lubridate")
library(lubridate)

#Converting Date and Time into datetime
data$datetime <- dmy_hms(paste(data$Date, data$Time))

#Opening png device
png(file = "plot4.png", width = 480, height = 480)

#Creating the plot
par(mfrow = c(2, 2))
with(data, {
  plot(datetime, Global_active_power, type = "l", xlab ="", ylab = "Global Active Power")
  plot(datetime, Voltage, type = 'l')
  plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  points(datetime, Sub_metering_1, type = "l")
  points(datetime, Sub_metering_2, type = "l", col = "red")
  points(datetime, Sub_metering_3, type = "l", col = "blue")
  legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime, Global_reactive_power, type = 'l')
})

#Closing the device
dev.off()