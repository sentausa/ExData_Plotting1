#Downloading the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "household_power_consumption.zip"
download.file(fileUrl, destination, method = "curl") ##I am using Mac, thus method = "curl"

#Creating the dataframe
header <- read.table(unz(destination, "household_power_consumption.txt"), sep = ";", header = TRUE, nrow = 1) ##to get the column names
data <- read.table(unz(destination, "household_power_consumption.txt"), col.names = names(header), sep = ";", skip = 66637, nrows = 2879, na.strings = "?")

#Creating the plot
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#Copying the plot to the png file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()