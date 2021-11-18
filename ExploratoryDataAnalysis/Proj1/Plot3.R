source("PlotCommon.R")

# Create second plot diagram and save to plot2.png file
makePlot3 <- function() {
  
  # Get wanted data
  theData <- getOrigData()
  wantedData <- getWantedData(theData)
  
  # Add new DateTime (POSIXlt) column to wantedData
  dtData <- paste(wantedData$Date, wantedData$Time, sep=" ")
  wantedData <- cbind.data.frame(wantedData,dtData, stringsAsFactors=FALSE)
  names(wantedData)[names(wantedData) == "dtData"] <- "DateTime"
  wantedData$DateTime <- strptime(wantedData$DateTime, format="%Y-%m-%d %H:%M:%S")
  
  # Create and save plot2 diagram to plot3.png file
  png(filename = "plot3.png", width = 480, height = 480, units="px")
  
  plot(wantedData$DateTime,wantedData$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(wantedData,lines(DateTime,as.numeric(Sub_metering_1)))
  with(wantedData,lines(DateTime,as.numeric(Sub_metering_2),col="red"))
  with(wantedData,lines(DateTime,as.numeric(Sub_metering_3),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  dev.off()
  
  print("The plot file was created and saved as plot3.png")
}

# Call makePlot3 function
makePlot3()
