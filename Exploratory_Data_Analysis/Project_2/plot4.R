##Set the working directory and read the files using readRDS function
setwd("C:/Users/james/SkyDrive/Data Science/Coursera_Exploratory_Data_Analysis/Exploratory_Data_Analysis/Project_2")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

##We need to see how the use of coal has been changed each year in the United States
use_of_coal <- vector()
use_of_coal <- grepl("Coal", SCC$Short.Name) #This shows as TRUE of FALSE if coal is seen in association with that specific source
SCC <- cbind(SCC, use_of_coal)

#Subset the data frame to get only the source values that include coal
SCC_coal <- SCC[SCC$use_of_coal=="TRUE",]
#Take the SCC values which are only associated with coal
US_coal <- data.frame()
for (i in 1:230){ #There are 230 'SCC' values that use coal
  coal <- NEI[NEI$SCC==SCC_coal$SCC[i],]
  US_coal <- rbind(US_coal, coal) #This data frame now only has emission info from coal sources
}

##Create a new data frame getting the total emissions from coal
##for each year in the United States
year <- vector()
emissions <- vector()
for (i in 1:4){
  temp_df <- US_coal[US_coal$year==unique(US_coal$year)[i],]
  year <- append(year, unique(US_coal$year)[i])
  emissions <- append(emissions, sum(temp_df$Emissions))  
}
USdf <- data.frame(cbind(year, emissions))

##Plot total PM2.5 emissions from coal in the United States
plot(USdf$year, USdf$emissions, main="US PM2.5 Emissions from Coal", 
     xlab="Year", ylab="Emissions", col="red", pch=20)
lines(USdf$year, USdf$emissions, col="blue")

##Create the png file of the graph
dev.copy(png, file="plot4.png")
dev.off()