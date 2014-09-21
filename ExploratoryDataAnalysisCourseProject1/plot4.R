plot4 <- function(workingDir)
{
  library(data.table) # for using fread to read in the dataset faster
  house_power_cons <- fread(paste(workingDir,"/household_power_consumption.txt",sep=""),sep=";",na.strings="?"
                            ,skip=66637,nrows=2879,)
  # the column names have V1,V2,... set them to their appropriate column name
  setnames(house_power_cons,c("V1","V2","V3","V4","V5","V6","V7","V8","V9"),
           c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
             "Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  # reduce the global axis and label font sizes for the 4 plots
  par(mfcol=c(2,2),cex.axis=.75,cex.lab=.75)
  
  with(house_power_cons,{
    # plot from plot2.R same code except not have to load the dataset more than once
    with(house_power_cons,plot(Global_active_power,type="l",xlab="",xaxt="n",ylab="Global Active Power"))
    axis(1,at=c(1, 1440,2879),labels=c("Thu","Fri","Sat"))
    
    # plot from plot3.R except the border is not there and the legend text is reduced
    with(house_power_cons,plot(Sub_metering_1,xaxt="n",type="l",xlab="",ylab="Energy sub metering"))
    with(house_power_cons,points(Sub_metering_2,type="l",col="red"))
    with(house_power_cons,points(Sub_metering_3,type="l",col="blue"))
    axis(1,at=c(1,1440,2879),labels=c("Thu","Fri","Sat"))
    legend("topright",lty=c(1,1,1),pch=c(NA,NA,NA),bty="n",cex=0.7,
           col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
    plot(Voltage,type="l",xlab="datetime",ylab="Voltage",xaxt="n")
    axis(1,at=c(1,1440,2879),labels=c("Thu","Fri","Sat"))
    
    plot(Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",xaxt="n")
    axis(1,at=c(1,1440,2879),labels=c("Thu","Fri","Sat"))
    axis(2,at=c(0.1,0.3,0.5))
  })
  dev.copy(png,file="plot4.png")
  dev.off()
}