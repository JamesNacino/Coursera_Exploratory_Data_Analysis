##Set the working directory and read the files using readRDS function
setwd("C:/Users/james/SkyDrive/Data Science/Coursera_Exploratory_Data_Analysis/Exploratory_Data_Analysis/Project_2")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

##Create a data frame for Baltimore emissions where fips=="24510"
Baltimore <- NEI[NEI$fips=="24510",]

##Create a new data frame getting the total emissions for each year in Baltimore
year <- vector()
emissions <- vector()
for (i in 1:4){
  temp_df <- Baltimore[Baltimore$year==unique(Baltimore$year)[i],]
  year <- append(year, unique(Baltimore$year)[i])
  emissions <- append(emissions, sum(temp_df$Emissions))  
}
Baltimoredf <- data.frame(cbind(year, emissions))

##Plot total PM2.5 emissions in Baltimore city
plot(Baltimoredf$year, Baltimoredf$emissions, main="Baltimore PM2.5 Emissions", 
     xlab="Year", ylab="Emissions", col="red", pch=20)
lines(Baltimoredf$year, Baltimoredf$emissions, col="blue")

##Create the png file of the graph
dev.copy(png, file="plot2.png")
dev.off() 