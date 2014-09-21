plot3 <- function(workingDir)
{
    library(ggplot2) 
    ## Load the rds files
    NEI <- readRDS(paste(workingDir,"/exdata-data-NEI_data/summarySCC_PM25.rds",sep=""))
    
    ## first select the observations such that the fips == 24510 (Baltimore City, Maryland)
    y1 <- subset(NEI,fips=="24510")
    
    ## use the qplot function to plot the total emissions for each year in Baltimore City for each type
    p <- qplot(factor(year),Emissions,data=y1,facets=~type,geom="bar",stat="summary",fun.y="sum",main="Total Emissions in
          Baltimore City vs Year Grouped by Source Type",xlab="Year of Emission Recorded",ylab="Total Emissions") +
        scale_x_discrete(breaks=seq(1999,2008,by=3))
    ggsave(filename="plot3.png",plot=p,width=6,height=6,dpi=100)
}