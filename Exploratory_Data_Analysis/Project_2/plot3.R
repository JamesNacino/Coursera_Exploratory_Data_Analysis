##Set the working directory and read the files using readRDS function
setwd("C:/Users/james/SkyDrive/Data Science/Coursera_Exploratory_Data_Analysis/Exploratory_Data_Analysis/Project_2")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

##Subset the emissions data set to include emissions only from Baltimore
Bal_NEI <- NEI[NEI$fips=="24510",]

##Create four data frames to include emissions coming from each type
point <- Bal_NEI[Bal_NEI$type=="POINT",]
nonpoint <- Bal_NEI[Bal_NEI$type=="NONPOINT",]
onroad <- Bal_NEI[Bal_NEI$type=="ON-ROAD",]
nonroad <- Bal_NEI[Bal_NEI$type=="NON-ROAD",]

##Create four data frames showing totalemissions coming from each type yearly
year <- as.numeric(c("1999","2002","2005","2008"))

##Final point data frame
point_emi <- vector()
for (i in 1:4){
  temp_df <- point
  temp_df <- temp_df[temp_df$year==unique(NEI$year)[i],]
  point_emi <- as.numeric(append(point_emi, sum(temp_df$Emissions)))
}
point_df <- data.frame(cbind(point_emi, year))

##Final Nonpoint data frame
nonpoint_emi <- vector()
for (i in 1:4){
  temp_df <- nonpoint
  temp_df <- temp_df[temp_df$year==unique(NEI$year)[i],]
  nonpoint_emi <- as.numeric(append(nonpoint_emi, sum(temp_df$Emissions)))
}
nonpoint_df <- data.frame(cbind(nonpoint_emi, year))

##Final onroad data frame
onroad_emi <- vector()
for (i in 1:4){
  temp_df <- onroad
  temp_df <- temp_df[temp_df$year==unique(NEI$year)[i],]
  onroad_emi <- as.numeric(append(onroad_emi, sum(temp_df$Emissions)))
}
onroad_df <- data.frame(cbind(onroad_emi, year))

##Final nonroad data frame
nonroad_emi <- vector()
for (i in 1:4){
  temp_df <- nonroad
  temp_df <- temp_df[temp_df$year==unique(NEI$year)[i],]
  nonroad_emi <- as.numeric(append(nonroad_emi, sum(temp_df$Emissions)))
}
nonroad_df <- data.frame(cbind(nonroad_emi, year))

##Make a panel plot of the four different types of emission in Baltimore
par(mfrow=c(2,2))
plot(point_df$year, point_df$point_emi, main="POINT", cex=.2, 
     xlab="Year", ylab="Emissions" ,pch=20)
lines(point_df$year, point_df$point_emi, col="blue")
plot(nonpoint_df$year, nonpoint_df$nonpoint_emi, main="NONPOINT", cex=.2, col="red", 
     xlab="Year", ylab="Emissions")
lines(nonpoint_df$year, nonpoint_df$nonpoint_emi, col="blue")
plot(onroad_df$year, onroad_df$onroad_emi, main="ON_ROAD", cex=.2, col="red", 
     xlab="Year", ylab="Emissions")
lines(onroad_df$year, onroad_df$onroad_emi, col="blue")
plot(nonroad_df$year, nonroad_df$nonroad_emi, main="NON-ROAD", cex=.2, col="red", 
     xlab="Year", ylab="Emissions")
lines(nonroad_df$year, nonroad_df$nonroad_emi, col="blue")

##Create the png file of the graph
dev.copy(png, file="plot3.png")
dev.off()