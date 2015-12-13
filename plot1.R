## Script to generate plot 1 for the project

## Ensure required packages are installed and load them

if(!require(dplyr)){
        install.packages("dplyr")
        library(dplyr)
}

## Download data if not existing

if (!file.exists("household_power_consumption.txt")){
        
        fileURL=paste("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2",
                      "Fhousehold_power_consumption.zip",sep="")
        download.file(fileURL,"unzippedPowerConsumption.zip",method="curl")
        unzip("unzippedPowerConsumption.zip")
        
}

## Read in data from the file

power_data<-read.table("household_power_consumption.txt",sep=";",header=TRUE,
                       na.strings="?",nrows=3*10^6,colClasses=c(rep("character",2),
                                                                rep("numeric",7)))

power_data<-power_data%>%mutate(Time=as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"),
                                Date=as.Date(Date,"%d/%m/%Y"))%>%
        filter(Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

## Create histogram

png("plot1.png",bg="transparent")

with(power_data,hist(Global_active_power,col="red",main="Global Active Power",
                     xlab="Global Active Power (kilowatts)"))

dev.off()
