
#download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "base_data.zip", method = "curl")
unzip("base_data.zip", exdir = ".")

#read download data
base_data <- read.table("./household_power_consumption.txt", 
                        header = TRUE, 
                        na.strings = "?", 
                        sep = ";", 
                        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

#subset base_data to and remove original data table to free space

sub_base_data <- subset(base_data, Date %in% c("1/2/2007", "2/2/2007"))
rm(base_data)

#dplyr
library(dplyr)

#new column date_time for x axis
sub_base_data$Date <- as.Date(sub_base_data$Date, "%d/%m/%Y")
sub_base_data <- mutate(sub_base_data, 
                        date_time=as.POSIXct(paste(sub_base_data$Date, sub_base_data$Time, sep=" "),
                                             template="%d/%m/%Y %H:%M:%S",
                                             tz=Sys.timezone()))

#plot date_time vs Global Active Power(kilowatts)

png("plot2.png", 
    width=480, 
    height=480)
plot(x=sub_base_data$date_time, 
     y=sub_base_data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()
