source("PlotCommon.R")

# Create second plot diagram and save to plot2.png file
makePlot4 <- function() {
  
  # Get wanted data
  theData <- getOrigData()
  wantedData <- getWantedData(theData)
  
  # Add new DateTime (POSIXlt) column to wantedData
  dtData <- paste(wantedData$Date, wantedData$Time, sep=" ")
  wantedData <- cbind.data.frame(wantedData,dtData, stringsAsFactors=FALSE)
  names(wantedData)[names(wantedData) == "dtData"] <- "DateTime"
  wantedData$DateTime <- strptime(wantedData$DateTime, format="%Y-%m-%d %H:%M:%S")
  
  # Create and save plot4 diagram to plot4.png file
  png(filename = "plot4.png", width = 480, height = 480, units="px")
  
  par(mfrow=c(2,2))
  
  with(wantedData,{
    
    plot(wantedData$DateTime,as.numeric(wantedData$Global_active_power),type="l",  xlab="",ylab="Global Active Power")
    
    plot(wantedData$DateTime,as.numeric(wantedData$Voltage), type="l",xlab="dateTime",ylab="Voltage")
    
    plot(wantedData$DateTime,wantedData$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    with(wantedData,lines(DateTime,as.numeric(Sub_metering_1)))
    with(wantedData,lines(DateTime,as.numeric(Sub_metering_2),col="red"))
    with(wantedData,lines(DateTime,as.numeric(Sub_metering_3),col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
    
    plot(wantedData$DateTime,as.numeric(as.character(wantedData$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
  })
  
  dev.off()
  
  print("The plot file was created and saved as plot3.png")
}

# Call makePlot4 function
makePlot4()
