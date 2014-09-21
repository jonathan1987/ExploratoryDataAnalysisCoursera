plot6 <- function(workingDir)
{
    library(ggplot2)
    ## Load the rds files
    NEI <- readRDS(paste(workingDir,"/exdata-data-NEI_data/summarySCC_PM25.rds",sep=""))
    SCC <- readRDS(paste(workingDir,"/exdata-data-NEI_data/Source_Classification_Code.rds",sep=""))
    
    ## first select the observations such that the fips == 24510 (Baltimore City, Maryland)
    ## and fips == "06037" (Los Angeles County, CA)
    NEI_balt_LA <- subset(NEI,fips == "24510" | fips == "06037")
    
    SCC_motorVehicle <- subset(SCC,EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles" | 
                                   EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" |
                                   EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" |
                                   EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles")
    
    SCC_motorVehicle_balt_LA <- merge(SCC_motorVehicle,NEI_balt_LA,by.x="SCC",by.y="SCC")
    
    p <- qplot(year,Emissions,data=SCC_motorVehicle_balt_LA,stat="summary",fun.y="sum",geom="bar",facets=.~fips,fill=EI.Sector,
               main="Total Emissions Based on \nMotor Vehicle Sources in Baltimore, MD (06037) and Los Angeles, CA (24510)",
               xlab="Year of Emission Recorded",
               ylab="Sqrt(Total Emission) in Tonnes") + 
        scale_x_continuous(breaks=seq(1999,2008,by=3)) +
        theme(plot.title=element_text(size=12)) +
        theme(legend.text=element_text(size=11),legend.title=element_text(size=11)) +
        scale_y_sqrt() # scale_y_log10() has some of the bars in the plot upside down, sqrt transform seems to work fine.
    ggsave(filename="plot6.png",plot=p,width=10,height=8,dpi=100)
}