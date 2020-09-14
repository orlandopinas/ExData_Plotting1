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
# config plot4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

##top left 
plot(x=sub_base_data$date_time, y=sub_base_data$Global_active_power,
     type="l", col="black", xlab="", ylab="Global active power")
##top right
plot(x=sub_base_data$date_time, y=sub_base_data$Voltage, 
     type="l", col="black", xlab="datetime", ylab="Voltage")
##Bottom left
with(sub_base_data,{
  plot(x=date_time, y=Sub_metering_1, 
       type="l", col="black", xlab="", ylab="Energy sub metering")
  lines(x=date_time, y=Sub_metering_2, type="l", col="red")
  lines(x=date_time, y=Sub_metering_3, type="l", col="blue")
  legend("topright", lty="solid", col=c("black", "red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
##Bottom right
plot(x= sub_base_data$date_time, y=sub_base_data$Global_reactive_power, 
     type="l", col="black",xlab="datetime", ylab="Global_ractive_power")
dev.off()


