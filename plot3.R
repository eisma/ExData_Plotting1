## read raw data
## 100'000 lines are enough

raw <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 100000)

## convert to class Date

raw[,1] <- as.Date(raw[,1], "%d/%m/%Y")

##subsetting (SELecting) the relevant dates

sel <- raw[,1] == "2007-02-01" | raw [,1] == "2007-02-02"
rawsub <- raw[sel == TRUE,]

## convert to class POSIXlt
dates <- rawsub[,1]
times <- rawsub[,2]
temp <- paste(dates, times)
DateTime <- strptime(temp, "%Y-%m-%d %H:%M:%S")
final <- data.frame(DateTime, rawsub[,3:9])

## plot3 and copy to PNG file

## assuming line width 1, and keeping the x-axes in the system langues which is German

## creating the empty space with the subset with the highest value, incl. legend
with(final, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## adding the three curves
with(final, lines(DateTime, Sub_metering_1, col = "black"))
with(final, lines(DateTime, Sub_metering_2, col = "red"))
with(final, lines(DateTime, Sub_metering_3, col = "blue"))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
