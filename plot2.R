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

## plot2 and copy to PNG file

## assuming line width 1, and keeping the x-axes in the system langues which is German
with(final, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
