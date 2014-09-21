plot5 <- function(workingDir)
{
    library(ggplot2)
    ## Load the rds files
    NEI <- readRDS(paste(workingDir,"/exdata-data-NEI_data/summarySCC_PM25.rds",sep=""))
    SCC <- readRDS(paste(workingDir,"/exdata-data-NEI_data/Source_Classification_Code.rds",sep=""))
    
    ## first select the observations such that the fips == 24510 (Baltimore City, Maryland)
    y1 <- subset(NEI,fips=="24510")
    
    ## by looking at summary(SCC$EI.Sector) The type of Emission it shows that there are three types of emission
    ## that are from Motor Vehicles (mobile and vehicle in the description and also on the road)
    ## Mobile - On-Road Diesel Heavy Duty Vehicles 311
    ## Mobile - On-Road Diesel Light Duty Vehicles 198
    ## Mobile - On-Road Gasoline Heavy Duty Vehicles 111 
    ## Mobile - On-Road Gasoline Light Duty Vehicles 518
    ## subset the SCC data that has these four emission types as their EI.Sector
    SCC_motorVehicle <- subset(SCC,EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles" | 
                                   EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" |
                                   EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" |
                                   EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles")
    
    SCC_motorVehicle_balt <- merge(SCC_motorVehicle,y1,by.x="SCC",by.y="SCC")
    
    p <- qplot(year,Emissions,data=SCC_motorVehicle_balt,stat="summary",fun.y="sum",fill=EI.Sector,geom="bar",
               main="Total Emissions Based on \nMotor Vehicle Sources in Baltimore, MD",xlab="Year of Emission Recorded",
               ylab="Total Emission in Tonnes") + 
        scale_x_continuous(breaks=seq(1999,2008,by=3)) +
        theme(plot.title=element_text(size=12))
    ggsave(filename="plot5.png",plot=p,width=7,height=7,dpi=100)
}