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
pdf(file="plot3.pdf")

# Create the first plot for sub_metering_1
# Use type = "l" to create a line
# ylab sets the verticle label on the left
# xlab sets the horizontal axis label - which is left blank
# col sets the line colour - in this case it's being set to black which is normally the default but its nice to make sure!
with(PowerData, plot(DateTime, Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab=""))
# create the second plot for sub_metering_2 on top of the first using lines()
# define the colour a red 
with(PowerData, lines(DateTime, Sub_metering_2, col="red"))
# And then a third blue plot for sub_metering_3
with(PowerData, lines(DateTime, Sub_metering_3, col="blue"))
# set the legend
# x = topright of the plot (y is null and not required)
# pch - characters to use - set to NA as we need a line (this could be omitted)
# col - use a charcter vector to set the colours 
# Legend - another character vector to set the text for each item
# lty - define the line thickness
legend("topright", pch=c(NA,NA,NA), col=c("black", "red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1))

# close the graphics device
dev.off()
