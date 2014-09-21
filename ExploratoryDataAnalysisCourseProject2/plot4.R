plot4 <- function(workingDir)
{
    library(ggplot2)
    ## Load the rds files
    NEI <- readRDS(paste(workingDir,"/exdata-data-NEI_data/summarySCC_PM25.rds",sep=""))
    SCC <- readRDS(paste(workingDir,"/exdata-data-NEI_data/Source_Classification_Code.rds",sep=""))
    
    ## by looking at summary(SCC$EI.Sector) The type of Emission it shows that there are three types of emission
    ## that are from coal combustion (coal and comb in the description)
    ## Fuel Comb - Comm/Institutional - Coal 31
    ## Fuel Comb - Electric Generation - Coal 35
    ## Fuel Comb - Industrial Boilers, ICEs - Coal  33 99 in total
    ## subset the SCC data that has these three emission types as their EI.Sector
    
    SCC_fuel_comb <- subset(SCC,EI.Sector == "Fuel Comb - Comm/Institutional - Coal" | 
                                EI.Sector == "Fuel Comb - Electric Generation - Coal" |
                                EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal")
    
    ## merge the data with the NEI data with matching SCC's
    NEI_SCC_fuel_comb <- merge(SCC_fuel_comb,NEI,by.x="SCC",by.y="SCC")
    p <- qplot(year,Emissions,data=NEI_SCC_fuel_comb,stat="summary",fun.y="sum",fill=EI.Sector,geom="bar",
               main="Total Emissions Based on Coal-Combustion Sources \nDuring 1999-2008",xlab="Year of Emission Recorded",
               ylab="Total Emission in tonnes") + 
        scale_x_continuous(breaks=seq(1999,2008,by=3)) +
        theme(plot.title=element_text(size=12))
    ggsave(filename="plot4.png",plot=p,width=7,height=7,dpi=100)
}