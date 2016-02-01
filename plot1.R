## Load dplyr package
library(dplyr)

plot1 <- function() {

   ## Read file using GREP; 2880 is numer of 1-minute intervals from Feb 1 to 2, 2007
   data <- read.table("household_power_consumption.txt", na.strings=c("?"), header=FALSE, sep=";", 
   	                skip=grep("31/1/2007;23:59:00", readLines("household_power_consumption.txt")),nrows=2880)

   ## Read trhe header into memory
   header <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, 
   	                  sep =';', stringsAsFactors = FALSE)

   ## Add header to data set
   colnames(data) <- unlist(header) 

   ## Set active device to PNG.
   png('plot1.png')   
   ## Plot histogram of Global_active_power column
   hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")   
   ## Turn PNG device off
   dev.off()

   ## Return the data so we can manipulate it further.
   data
}