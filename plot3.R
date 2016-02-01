## Load dplyr package
library(dplyr)

plot3 <- function() {

   ## Read file using GREP; 2880 is numer of 1-minute intervals from Feb 1 to 2, 2007
   data <- read.table("household_power_consumption.txt", na.strings=c("?"), header=FALSE, sep=";", 
   	                skip=grep("31/1/2007;23:59:00", readLines("household_power_consumption.txt")),nrows=2880)

   ## Read trhe header into memory
   header <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, 
   	                  sep =';', stringsAsFactors = FALSE)

   ## Add header to data set
   colnames(data) <- unlist(header) 

   ## Concatenate date and time columns and convert it to a posixct object, 
   ## and save in a new column 'DateTime'	
   data <- mutate(data, DateTime = as.POSIXct( strptime( trimws(paste(Date, Time, " ")), format="%d/%m/%Y %H:%M:%S" ) ) ) 

   ## Set active device to PNG and adjust the plot's margins
   png('plot3.png')      
   par(mar=c(2.8,4.3,0.85,0.85))

   ## Plot line graph of Global_active_power column vs day of week.
   plot(data$DateTime, data$Sub_metering_1, type="l", ylab="Energy sub metering", cex=0.75)   
   lines(data$DateTime, data$Sub_metering_2, type="l", col="red")   
   lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")   
   legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), cex=1.1 )

   ## Turn PNG device off
   dev.off()

   ## Return the data so we can manipulate it further.
   data
}