#############################################
### PROJECT 1 - EXPLORATORY DATA ANALYSIS ###
### DONE BY: RAM KHARAWALA                ###
### R code for Plot4.png                  ###
#############################################

rm(list=ls())
#Download data file if its not there
if(!file.exists("household_power_consumption.txt")){
  dir.create("Project_1")  
  
  # file URL & destination file
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  destfile <- "./Project_1/power_consumption.zip"
  
  # download the file & note the time
  download.file(fileUrl, destfile)
  
  # set the file to read
  d <- file("./Project_1/household_power_consumption.txt", "r");
}else{
  d <- file("household_power_consumption.txt", "r");
}

# read in the data until date
data <- read.table(text = grep("^[1,2]/2/2007", readLines(d), value = TRUE), 
                    sep = ";", skip = 0, na.strings = "?", stringsAsFactors = FALSE)

# rename the columns
names(data) <- c("date", "time", "active_power", "reactive_power", "voltage",
                  "intensity", "sub_metering_1", "sub_metering_2", 
                  "sub_metering_3")

# add a new date-time formated column
data$new_time <- as.POSIXct(paste(data$date, data$time), format = "%d/%m/%Y %T")

# plot 4 - All
png(filename='plot4.png',width=480,height=480,units='px')
par(mfrow = c(2, 2))
with(data, {
  plot(new_time, active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(new_time, voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(new_time, sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(new_time, sub_metering_2, col = "red")
  lines(new_time, sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), cex = 0.7, lty = 1, bty = "n",
         legend = c("Sub_metering_1", 
                    "Sub_metering_2",
                    "Sub_metering_3"))
  plot(new_time, reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")
})

# close connection to png device
dev.off()
