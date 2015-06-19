##Set the working directory and read the files using readRDS function
setwd("C:/Users/james/SkyDrive/Data Science/Coursera_Exploratory_Data_Analysis/Exploratory_Data_Analysis/Project_2")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

##We need to see how the use of motor vehicles has been changed each year in Baltimore
Motor_veh <- vector()
Motor_veh <- grepl("Vehicle", SCC$SCC.Level.Two) #This shows as TRUE of FALSE if a vehicle is seen in association with that specific source
SCC <- cbind(SCC, Motor_veh)

#Subset the data frame to get only the source values that are associated with motor vehicles
NEI <- NEI[NEI$fips=="24510",] ##Subset to get only vehicle emission from Baltimore
SCC_Motor <- SCC[SCC$Motor_veh=="TRUE",]
#Take the SCC values which are only associated with vehicles
Bal_veh <- data.frame()
for (i in 1:1452){ #There are 1452 'SCC' values that are associated with vehicles
  motor <- NEI[NEI$SCC==SCC_Motor$SCC[i],]
  Bal_veh <- rbind(Bal_veh, motor) #This data frame now only has emission info from vehicle sources
}

##Create a new data frame getting the total emissions from vehicles
##for each year in Baltimore
year <- vector()
emissions <- vector()
for (i in 1:4){
  temp_df <- Bal_veh[Bal_veh$year==unique(Bal_veh$year)[i],]
  year <- append(year, unique(Bal_veh$year)[i])
  emissions <- append(emissions, sum(temp_df$Emissions))  
}
Baldf <- data.frame(cbind(year, emissions))
Baldf <- Baldf[order(Baldf$year),] #Sort the year ascending order


#Subset the data frame to get only the source values that are associated with motor vehicles
NEI <- readRDS("./Data/summarySCC_PM25.rds")
NEI_LA <- NEI[NEI$fips=="06037",] ##Subset to get only vehicle emission from Los Angeles County
SCC_Motor <- SCC[SCC$Motor_veh=="TRUE",]
#Take the SCC values which are only associated with vehicles
LA_veh <- data.frame()
for (i in 1:1452){ #There are 1452 'SCC' values that are associated with vehicles
  motor <- NEI_LA[NEI_LA$SCC==SCC_Motor$SCC[i],]
  LA_veh <- rbind(LA_veh, motor) #This data frame now only has emission info from vehicle sources
}

##Create a new data frame getting the total emissions from vehicles
##for each year in Los Angeles
year <- vector()
emissions <- vector()
for (i in 1:4){
  temp_df <- LA_veh[LA_veh$year==unique(LA_veh$year)[i],]
  year <- append(year, unique(LA_veh$year)[i])
  emissions <- append(emissions, sum(temp_df$Emissions))  
}
LAdf <- data.frame(cbind(year, emissions))
LAdf <- LAdf[order(LAdf$year),] #Sort the year ascending order

##Plot total PM2.5 emissions from vehicles in Baltimore and Los Angeles
par(mfrow=c(2,1), mar=c(4,4,4,4))
plot(Baldf$year, Baldf$emissions, main="Baltimore PM2.5 Emissions from Vehicles",
     xlab="Year", ylab="Emissions", col="red", pch=20)
lines(Baldf$year, Baldf$emissions, col="blue")

plot(LAdf$year, LAdf$emissions, main="LA County PM2.5 Emissions from Vehicles",
     xlab="Year", ylab="Emissions", col="red", pch=20)
lines(LAdf$year, LAdf$emissions, col="blue")

##Create the png file of the graph
dev.copy(png, file="plot6.png")
dev.off()