# This script reads in a data file, and then outputs a 2 x 2 panel of graphs,
# including a line plot of the "Global_active_power" variable versus the DateTime
# variable; a line plot of "Voltage" versus the DateTime variable; a multi-line
# plot of the three "Sub_metering" variables, versus the DateTime variable; and
# a line plot of the "Global_reactive_power" variable versus the DateTime variable.
# The histogram is output to a png file named "plot4.png".

# The script assumes that the file "househole_power_consumption.txt" is present
# in the working directory.

# Read first 5 lines of the data file
data5rows <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, nrows = 5)

# Determine the class of each column in the table (facilitates the subsequent read operation)
colclasses = sapply(data5rows, class)

# Read data from .txt file into the "data" dataframe
data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, colClasses = colclasses)

# Extract a subset the data, restricted to the desired date range
data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

# Adds a column to the data frame for combined data/time variable, combines the Date and Time
# variable values, and then converts the result to POSIX format.
data$DateTime <- strptime(paste(as.character(data$Date), data$Time), format="%d/%m/%Y %H:%M:%S")

# Open a graphics device
png("plot4.png", height = 480, width = 480)

#Set up 2 x 2 panel plot
par(mfrow = c(2,2))

# Plot first graph; appears in top left position
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot second graph; appears in top right position
plot(data$DateTime, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

# Plot third graph; appears in bottom left position
plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
points(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", bty = "n", lwd=2, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot fourth graph; appears in bottom right position
plot(data$DateTime, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

# Close graphics device
dev.off()