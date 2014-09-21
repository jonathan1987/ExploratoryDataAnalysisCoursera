plot1 <- function(workingDir)
{
    ## Load the rds files
    NEI <- readRDS(paste(workingDir,"/exdata-data-NEI_data/summarySCC_PM25.rds",sep=""))
    
    ## use tapply to comptute the sum of emissions for each year
    y <- tapply(NEI$Emissions,NEI$year,sum)
    
    ##plot a total emissions vs year barplot
    barplot(y,NEI$year,main="Total Emissions From PM_25 vs Year", cex.main = .85, 
            xlab = "Year of Emission Recorded",ylab= "Total Emissions From PM_25 (in tonnes)")
    
    dev.copy(png,file="plot1.png")
    dev.off()
}