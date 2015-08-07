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

# open the PDF graphics device
pdf(file="plot1.pdf")

# Create the histogram using hist()
# col sets the plotting colour - in this case, red
# ylab sets the verticle label on the left
# xlab sets the horizontal axis label
# main sets the chart title
hist(PowerData$Global_active_power, col = "red", xlab="Global Active Power(kilowatts)", ylab="Frequency", main="Global Active Power")

# close the graphics device
dev.off()


