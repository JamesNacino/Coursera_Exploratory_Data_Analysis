##Set the working directory and read the files using readRDS function
setwd("C:/Users/james/SkyDrive/Data Science/Coursera_Exploratory_Data_Analysis/Exploratory_Data_Analysis/Project_2")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

##Create four separate data frames. One data frame for each unique date
##Then sum the total emissions for each unique date
#Year 1999 data frame
df1999 <- NEI[NEI$year==unique(NEI$year)[1],]
total_pol_1999 <- as.numeric(sum(df1999$Emissions))

#Year 2002 data frame
df2002 <- NEI[NEI$year==unique(NEI$year)[2],]
total_pol_2002 <- as.numeric(sum(df2002$Emissions))

#Year 2005 data frame
df2005 <- NEI[NEI$year==unique(NEI$year)[3],]
total_pol_2005 <- as.numeric(sum(df2005$Emissions))

#Year 2008 data frame
df2008 <- NEI[NEI$year==unique(NEI$year)[4],]
total_pol_2008 <- as.numeric(sum(df2008$Emissions))

##Create a separate data frame showing the year and total pollution for that year
pollution <- data.frame(year=as.numeric(c("1999","2002","2005","2008")),
                        emissions=c(total_pol_1999,total_pol_2002,total_pol_2005,total_pol_2008))

##Create a plot showing the total PM2.5 emissions for each year
plot(pollution$year, pollution$emissions, main="Total PM2.5 Emissions", 
     xlab="Year", ylab="Emissions", cex=.2, col="red")
lines(pollution$year, pollution$emissions, col="blue")

##Create the png file of the graph
dev.copy(png, file="plot1.png")
dev.off() 
