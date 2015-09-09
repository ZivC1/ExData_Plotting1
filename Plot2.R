
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
png(file="plot2.png")

## draw the chart
with(x, plot(Date, Global_active_power, type="n", xlab="", ylab = "Global Active Power (kilowatts)"))
lines(x$Date, x$Global_active_power)

## close device
dev.off()
