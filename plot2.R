## Load dplyr package
library(dplyr)

plot2 <- function() {

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
   png('plot2.png')      
   par(mar=c(2.5,4.5,1,1))

   ## Plot line graph of Global_active_power column vs day of week.
   plot(data$DateTime, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)")   

   ## Turn PNG device off
   dev.off()

   ## Return the data so we can manipulate it further.
   data
}