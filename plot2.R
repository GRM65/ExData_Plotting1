# This script reads in a data file, and then outputs a plot of of the 
# "Global_active_power" variable versus the date and time. The plot is 
# output to a png file named "plot2.png".

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
png("plot2.png", height = 480, width = 480)

# Plot the graph
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Close the graphics device
dev.off()