# PlotComm.R is a common function file. All four different plot creation scripts
# call this file to get the wanted data

getOrigData <- function(){
  datafile <- "exdata_data_household_power_consumption.zip"
  
  ## Download and unzip the zip dataset:
  if (!file.exists("household_power_consumption.txt")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, datafile, method="curl")
  }  
  if (!file.exists("household_power_consumption.txt")) { 
    unzip(thefile) 
  }
  # Get the original data in data.frame
  return(read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE))
}

# Get the data on 2007-02-01 and 2007-02-02
getWantedData <- function(theData) {
  
  #Get 2007-02-01 and 2007-02-01 data
  wantedData <- subset(theData, as.Date(strptime(theData$Date, "%d/%m/%Y")) == as.Date("2007-02-01") | 
                         as.Date(strptime(theData$Date, "%d/%m/%Y")) == as.Date("2007-02-02"))
  
  #Convert date to normal date string
  wantedData$Date <- as.Date(strptime(wantedData$Date, "%d/%m/%Y"))
  
  return(wantedData)
}