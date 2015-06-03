#url to file "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#setwd("C:/Users/james/SkyDrive/Data Science/DataScience_Coursera/Exploratory_Data_Analysis/Project_1")
#NOTE!!! File size for "household_power_consumption.txt" is too large to sync to github. Must download file to working directory

##Clean the data
ElecPowerCon <- read.csv("household_power_consumption.txt", sep=";")
clean <- ElecPowerCon[ElecPowerCon$Date=="1/2/2007" | ElecPowerCon$Date=="2/2/2007",]
clean$Date <- strptime(clean$Date, format="%d/%m/%Y")
clean2 <- cbind(clean, "Date_Time" = paste(clean$Date, clean$Time))
clean2$Date_Time <- strptime(clean2$Date_Time, format="%Y-%m-%d %T")
clean2$Global_active_power <- as.numeric(as.character(clean2$Global_active_power))

##Construct the second plot (scatterplot)
with(clean2, plot(Date_Time, Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", pch=20))
lines(clean2$Date_Time, clean2$Global_active_power)
#Save as '.png' file
dev.copy(png, file="plot_2.png")
dev.off() 