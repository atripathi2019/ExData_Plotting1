library(dplyr)
filename <- "exdata_data_household_power_consumption.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename)
}  

# Checking if folder exists
if (!file.exists("exdata_data_household_power_consumption")) { 
  unzip(filename) 
  }

# Read the csv for only the data we need
library(sqldf)
part_data <- read.csv.sql("household_power_consumption.txt", "select * from file where Date = '2/1/2007' OR Date = '2/2/2007' ", sep=";")

# Remove "?" and replace it with 'NA'
part_data_na <- na_if(part_data, "[?]")

#Create the png file with the graph
hist(part_data_na$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.print(png, file = "plot1.png", width = 480, height = 480)
dev.off()
