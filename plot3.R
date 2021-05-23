library(dplyr)
library(tidyr)
library(lubridate)
x <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE) #read the file
x <- x[x$Date %in% c("1/2/2007","2/2/2007") ,] #extract the relevant dates
x <- mutate(x, Ddate = as.Date(Date, format = "%d/%m/%y")) # convert the Date columns to a new Date column of class date
x <- select(x, -Date) # remove old Date column of class factor
x_1 <- paste(x$Ddate, x$Time) # making one column of date and time
y <- cbind(x, as.POSIXct(x_1)) # adding the new column to df and making it class POSIXct
names(y)[10] <- "datetime" # renaming that new column

# creating plot no3
with(y, {plot(Sub_metering_1~datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~datetime,col='Red')
        lines(Sub_metering_3~datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png")
dev.off()