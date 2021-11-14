# run_analysis.R

library(reshape2)

thefile <- "getdata_dataset.zip"

## Download and unzip the zip dataset:
if (!file.exists("thefile")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, thefile, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(thefile) 
}

# Read activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract the data on mean and standard deviation
desiredFeature <- grep("*mean*|*std*", features[,2])
desiredFeature.names <- features[desiredFeature,2]
desiredFeature.names = gsub('-mean', 'Mean', desiredFeature.names)
desiredFeature.names = gsub('-std', 'Std', desiredFeature.names)
desiredFeature.names <- gsub('[-()]', '', desiredFeature.names)


# Load the train datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[desiredFeature]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# Load the test datasets
test <- read.table("UCI HAR Dataset/test/X_test.txt")[desiredFeature]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge train and test dataset and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", desiredFeature.names)

# turn activities & subjects into factors with meaningful labels
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "CleanData.txt", row.names = FALSE, quote = FALSE)
