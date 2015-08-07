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
pdf(file="plot1.pdf")

# Create the plot
# Use type = "l" to create a line
# ylab sets the verticle label on the left
# xlab sets the horizontal axis label - which is left blank
plot(PowerData$DateTime, PowerData$Global_active_power, type="l", ylab="Global Active Power(kilowatts)", xlab="")

# close the graphics device
dev.off()
