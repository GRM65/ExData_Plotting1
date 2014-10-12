# This script reads in a data file, and then outputs a histogram of the
# "Global_active_power" variable. The histogram is output to a png 
# file named "plot1.png".

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
png("plot1.png", height = 480, width = 480)

# Plot histogram of the "Global_active_power" variable, setting the color to red, and
# adding a title and x-axis label.
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close the graphics device
dev.off()

