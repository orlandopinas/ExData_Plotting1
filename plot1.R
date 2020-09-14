#download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "base_data.zip", method = "curl")
unzip("base_data.zip", exdir = ".")

#read download data
base_data <- read.table("./household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";")

#change class of all columns to correct class
base_data$Date <- as.Date(base_data$Date, format="%d/%m/%Y")
base_data$Time <- format(base_data$Time, format="%H:%M:%S")
base_data$Global_active_power <- as.numeric(base_data$Global_active_power)

#subset data from 2007-02-01 to 2007-02-02
sub_base_data <- subset(base_data, Date == "2007-02-01" | Date == "2007-02-02")

#plot histogram of global active power for those days
png("plot1.png", width = 480, height = 480)
hist(sub_base_data$Global_active_power, col="red", border="black", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()