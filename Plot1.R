
## Load the file into a table 'x'
x <-read.csv("household_power_consumption.txt", nrows = 2100000, sep = ";", header = TRUE, colClasses = "character")

## subset the huge file to the relevant dates only into a table 'x'
x <- subset(x, (Date =="1/2/2007") | (Date =="2/2/2007"))

## converting relevant columns to class "numeric"
cols = c(3,4,5,6,7,8,9)
x[, cols] <- apply(x[, cols], 2, function(t) as.numeric(t))

##open device to create a .png file
png(file="plot1.png")

## draw the histogram
hist(x$Global_active_power, col = 10, main="Global Active Power", xlab = "Global Active Power (kilowatts)" )

## close device
dev.off()
