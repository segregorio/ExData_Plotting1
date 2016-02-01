## Load dplyr package
library(dplyr)

plot4 <- function() { 

   ## Load data from file and assign to data frame 'data'
   data <- load_data()

   ## Set active device to PNG and adjust the plot's margins
   png('plot4.png')         

   par(mfrow=c(2,2))

   ## Plot 2 - line graph of Global_active_power column vs day of week.
   par(mar=c(4.5,4.5,1.4,0.85))
   plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")   

   ## Plot_vodt - line graph of Voltage (y) vs datetime (x)
   par(mar=c(4.5,4.5,1.4,0.85))
   plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage", cex=0.6)   

   ## Plot 3 - line graph of sub_metering_1, _2, and _3 (y) vs day of week (x)
   par(mar=c(4.0,4.5,1.2,0.85))
   plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", cex=0.75)   
   lines(data$DateTime, data$Sub_metering_2, type="l", col="red")   
   lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")   
   legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
          col=c("black", "red", "blue"), lty=c(1,1,1), cex=0.8, bty="n" )

   ## Plot_grpdt -  line graph of Global_reactive_power column (y) vs day of week (x)
   plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.6)   
   par(mar=c(4.0,4.5,1.2,0.85))

   ## Turn PNG device off
   dev.off()

   ## Return the data so we can manipulate it further.
   data
} 

## load_data is just a helper function that reads data from source file and returns data frame.

load_data <- function() {
   ## Read file using GREP; 2880 is numer of 1-minute intervals from Feb 1 to 2, 2007
   data <- read.table("household_power_consumption.txt", na.strings=c("?"), header=FALSE, sep=";", 
                      skip=grep("31/1/2007;23:59:00", readLines("household_power_consumption.txt")),nrows=2880)
   ## Read trhe header into memory
   header <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, 
                        sep =';', stringsAsFactors = FALSE)
   ## Add header to data set
   colnames(data) <- unlist(header) 
   ## Return data

   ## Concatenate date and time columns and convert it to a posixct object, 
   ## and save in a new column 'DateTime' 
   data <- mutate(data, DateTime = as.POSIXct( strptime( trimws(paste(Date, Time, " ")), format="%d/%m/%Y %H:%M:%S" ) ) ) 

   data
} 