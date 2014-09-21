plot2 <- function(workingDir)
{
  library(data.table) # for using fread to read in the dataset faster
  house_power_cons <- fread(paste(workingDir,"/household_power_consumption.txt",sep=""),sep=";",na.strings="?"
                            ,skip=66637,nrows=2879,)
  # the column names have V1,V2,... set them to their appropriate column name
  setnames(house_power_cons,c("V1","V2","V3","V4","V5","V6","V7","V8","V9"),
           c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
             "Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  with(house_power_cons,plot(Global_active_power,type="l",xlab="",xaxt="n",ylab="Global Active Power (kilowatts)",cex.lab=.75,cex.axis=.75))
  axis(1,at=c(1, 1440,2879),labels=c("Thu","Fri","Sat"),cex.axis=.75)
  dev.copy(png,file="plot2.png")
  dev.off()
}