# Plot 2

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

png(filename = "plot2.png",
    width = 480, height = 480, units = "px")

plot(householddata$DateTime,householddata$Global_active_power, 
     ylab="Global Active Power (kilowatts)", xlab = "",
     col="black", type = "l")

dev.off()