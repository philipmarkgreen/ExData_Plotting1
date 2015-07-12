# Plot 4

library(dplyr)

zipfile <- "exdata_household_power_consumption.zip"
textfile <- "household_power_consumption.txt"

# Check if we have already downloaded the file. If not, lets grab it.
if(!file.exists(zipfile)) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                      ,zipfile)
}

# Unzip the file and read in the data
unzip(zipfile, textfile)
householddata <- read.csv(textfile, na.strings = "?", sep=";",
                          stringsAsFactors = FALSE, 
                          colClasses = c(rep("character",2),rep("numeric",7)))

# Change the Date to 
householddata <- mutate(householddata, Date = as.Date(Date,"%d/%m/%Y"))

# Filter
householddata <- filter(householddata, Date == "2007-02-01" | Date == "2007-02-02")

# Amalgamage Date and Time
householddata <- mutate(householddata, 
                        DateTime = as.POSIXct(paste(Date, Time), 
                                              format="%Y-%m-%d %H:%M:%S"))

# Open our PNG file with correct size
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

# Set up for four plots, we use column so we will fill the left column first
par(mfcol=c(2,2))

# (1,1) - Plot 2
plot(householddata$DateTime,householddata$Global_active_power, 
     ylab="Global Active Power", xlab = "",
     col="black", type = "l")

# (2,1) - Plot 2
plot(householddata$DateTime,householddata$Sub_metering_1, 
     ylab="Energy sub metering", xlab = "",
     col="black", type = "l")
points(householddata$DateTime,householddata$Sub_metering_2, 
       col="red", type="l")
points(householddata$DateTime,householddata$Sub_metering_3, 
       col="blue", type="l")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red","blue"),lty=1)

# (1,2) 
plot(householddata$DateTime,householddata$Voltage, 
     ylab="Voltage", xlab = "datetime",
     col="black", type = "l")

# (2,2) 
plot(householddata$DateTime,householddata$Global_reactive_power, 
     ylab="Global_reactive_power", xlab = "datetime",
     col="black", type = "l")

dev.off()