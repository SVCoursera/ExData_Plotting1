#####################################################################################################
#
# INITIALISATION
#
# Code assumes that the working directory contains the file household_power_consumption.txt
#
# Output will be written to the working directory
#
#####################################################################################################

# If you do not have the SQLDF package installed then install it
#
# install.packages("sqldf")
#

# Open the SQLDF library
library(sqldf)

# load the data using SQLDF to filter the input rows
PowerData <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'", sep=";" )
# Create a date-time column by joining the date and time columns and then converting to the right datatype using strptime
PowerData$DateTime <- strptime(paste(PowerData$Date, " ", PowerData$Time), "%d/%m/%Y %H:%M:%S")

# open the PDF graphics device
pdf(file="plot4.pdf")

# Use par() to define the layout of the plots to follow
# mfrom - sets the plot layout as 2 rows of 2 columns
# mar and oma set the margins around the plots and their associated text boxes
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# Plot 1 - same as plot 1 in the assignment
plot(PowerData$DateTime, PowerData$Global_active_power, type="l", ylab="Global Active Power(kilowatts)", xlab="")

# plot 2
plot(PowerData$DateTime, PowerData$Voltage, type="l", ylab="Voltage", xlab="")

# plot 3
with(PowerData, plot(DateTime, Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab=""))
with(PowerData, lines(DateTime, Sub_metering_2, col="red"))
with(PowerData, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", col=c("black", "red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), bty="n")

# plot 4
plot(PowerData$DateTime, PowerData$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="")

# close the graphics device
dev.off()
