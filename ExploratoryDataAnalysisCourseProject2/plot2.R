plot2 <- function(workingDir)
{
    ## Load the rds files
    NEI <- readRDS(paste(workingDir,"/exdata-data-NEI_data/summarySCC_PM25.rds",sep=""))
    
    ## first select the observations such that the fips == 24510 (Baltimore City, Maryland)
    y1 <- subset(NEI,fips=="24510")
    ## use tapply to comptute the sum of emissions for each year
    y <- tapply(y1$Emissions,y1$year,sum)
    
    ##plot a total emissions vs year barplot
    barplot(y,NEI$year,main="Total Emissions From PM_25 in Baltimore City vs Year", cex.main = .85, 
            xlab = "Year of Emission Recorded",ylab= "Total Emissions From PM_25 (in tonnes)")
    
    dev.copy(png,file="plot2.png")
    dev.off()
}