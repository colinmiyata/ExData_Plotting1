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

## Plot the figure

png("plot4.png",bg="transparent")

par(mfcol=c(2,2))

with(power_data,plot(Time,Global_active_power,type="l",col="black",xlab="",
                     ylab="Global Active Power (kilowatts)"))

with(power_data,{
        plot(Time,Sub_metering_1,type="l",col="black",xlab="",
             ylab="Energy sub metering")
        lines(Time,Sub_metering_2,col="red")
        lines(Time,Sub_metering_3,col="blue")})

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"),bty="n")

with(power_data,plot(Time,Voltage,type="l",col="black",xlab="datetime"))

with(power_data,plot(Time,Global_reactive_power,type="l",col="black",xlab="datetime"))

dev.off()