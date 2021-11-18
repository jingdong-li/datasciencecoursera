source("PlotCommon.R")

# Create second plot diagram and save to plot2.png file
makePlot2 <- function() {
  
  # Get wanted data
  theData <- getOrigData()
  wantedData <- getWantedData(theData)
  
  # Add new DateTime (POSIXlt) column to wantedData
  dtData <- paste(wantedData$Date, wantedData$Time, sep=" ")
  wantedData <- cbind.data.frame(wantedData,dtData, stringsAsFactors=FALSE)
  names(wantedData)[names(wantedData) == "dtData"] <- "DateTime"
  wantedData$DateTime <- strptime(wantedData$DateTime, format="%Y-%m-%d %H:%M:%S")
  
  # Create and save plot2 diagram to plot2.png file
  png(filename = "plot2.png", width = 480, height = 480, units="px")
  plot(wantedData$DateTime, wantedData$Global_active_power, type="l",
       xlab="",ylab="Global Active Power (kilowatts)")
  title(main="Global Active Power Vs Time")
  dev.off()
  
  print("The plot file was created and saved as plot2.png")
}

# Call makePlot2 function
makePlot2()
