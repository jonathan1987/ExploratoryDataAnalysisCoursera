plot1 <- function(workingDir)
{
  library(data.table) # for using fread to read in the dataset faster
  house_power_cons <- fread(paste(workingDir,"/household_power_consumption.txt",sep=""),sep=";",na.strings="?"
                            ,skip=66637,nrows=2879)
  # the column names have V1,V2,... set them to their appropriate column name
  setnames(house_power_cons,c("V1","V2","V3","V4","V5","V6","V7","V8","V9"),
           c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
          "Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  with(house_power_cons,hist(Global_active_power,col="red",cex.main=.85,
                           main="Global Active Power",xlab="Global Active Power (kilowatts)"))
  dev.copy(png,file="plot1.png")
  dev.off()
}