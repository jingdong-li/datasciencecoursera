source("PlotCommon.R")
# Create first histo plot diagram and save to plot1.png file
makePlot1 <- function() {
  # Get wanted data
  theData <- getOrigData()
  wantedData <- getWantedData(theData)
  
  # Create and save plot1 diagram to plot1.png file
  png(filename = "plot1.png", width = 480, height = 480, units="px")
  
  hist(as.numeric(wantedData$Global_active_power), 
       col = "red", 
       main="Global Active Power", 
       xlab="Global Active Power (kilowatts)", 
       ylab="Frequency")
  
  dev.off()
  print("The hist plot file was created and saved as plot1.png")
}

# Call makePlot1 function
makePlot1()

