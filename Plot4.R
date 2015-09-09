
## Load the file into a table 'x'
x <-read.csv("household_power_consumption.txt", nrows = 2100000, sep = ";", header = TRUE, colClasses = "character")

## subset the huge file to the relevant dates only into a table 'x'
x <- subset(x, (Date =="1/2/2007") | (Date =="2/2/2007"))

## converting relevant columns to class "numeric"
cols = c(3,4,5,6,7,8,9)
x[, cols] <- apply(x[, cols], 2, function(t) as.numeric(t))

# combine columns of Date and Time together to prepare for conversion to POSIXct
x[,"Date"]<- paste(x[ ,"Date"], x[ ,"Time"], sep = " ")
x$Time <- NULL  ## remove un redundant column

## convert to POSIXct
x[, "Date"] <- as.POSIXct(x[, "Date"], format ="%d/%m/%Y %H:%M:%S")

##open device to create a .png file
png(file="plot4.png")

## draw the charts
## define the canvas of 2 by 2 small charts
par(mfrow = c(2, 2), oma= c(4,2,4,2))

## Draw Chart 1
with(x, plot(Date, Global_active_power, type="n", xlab="", ylab = "Global Active Power (kilowatts)"))
lines(x$Date, x$Global_active_power)

## Draw Chart 2
with(x, plot(Date, Voltage, type="n", xlab="datetime", ylab = "voltage"))
lines(x$Date, x$Voltage)

##Draw Chart 3
## draw the empty chart
with(x, plot(Date, Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering"))
## draw the lines with colors
lines(x$Date, x$Sub_metering_1, col="black") 
lines(x$Date, x$Sub_metering_2, col="red")
lines(x$Date, x$Sub_metering_3, col="blue")
# draw the legend
legend("topright", lty="solid", col = c("black", "red", "blue"),legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty =  "n")

##Draw Chart 4
with(x, plot(Date, Global_reactive_power, type="n", xlab="datetime"))
lines(x$Date, x$Global_reactive_power)

## close device
dev.off()
