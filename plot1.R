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

# creating plot no1
hist(x$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()