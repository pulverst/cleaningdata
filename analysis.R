#R script for Peer-graded Assignment: Getting and Cleaning Data Course Project
#2020/01/16PSt - Version 1.0.0

#Step 1: Sources
fileName <- "UCIdata.zip"
dataSourceURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dirName <- "UCI HAR Dataset"

#Download data file if fileName does not exists in working diroctory and remove dirName
# -> to initiate a fresh download just rename or remove fileName from WD

if(!file.exists(fileName)){
  download.file(dataSourceURL, fileName, mode = "wb")

  #remove old data
  if(file.exists(dirName)){
    unlink(dirName, recursive = TRUE, force = TRUE)
  }

}

#unzip if dirName does not exist
if(!file.exists(dirName)){
  unzip(fileName, files = NULL, exdir=".")
}

#Step 2: Libraries
library("reshape2")

#Step 3: Create data tables
trainDir <- "train"
testDir <- "test"

subject_test <- read.table(paste(dirName, testDir, "subject_test.txt", sep = "/"))
subject_train <- read.table(paste(dirName, trainDir, "subject_train.txt", sep = "/"))
X_test <- read.table(paste(dirName, testDir, "X_test.txt", sep = "/"))
X_train <- read.table(paste(dirName, trainDir, "X_train.txt", sep = "/"))
Y_test <- read.table(paste(dirName, testDir, "y_test.txt", sep = "/"))
Y_train <- read.table(paste(dirName, trainDir, "y_train.txt", sep = "/"))

activity_labels <- read.table(paste(dirName, "activity_labels.txt", sep = "/"))
features <- read.table(paste(dirName, "features.txt", sep = "/"))

#Step 4: Clean data
#Merge the training and the test sets to create one data set
dataSet <- rbind(X_train, X_test)

#Extract measurements on the mean and standard deviation for each measurement
meanStdOnly <- grep("mean()|std()", features[, 2]) 
dataSet <- dataSet[, meanStdOnly]

#Label the data
headers <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(dataSet) <- headers[meanStdOnly]

#Combine data from test and train
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'
activity <- rbind(Y_train, Y_test)
names(activity) <- 'activity'
dataSet <- cbind(subject, activity, dataSet)

#Descriptive names
activity_group <- factor(dataSet$activity)
levels(activity_group) <- activity_labels[,2]
dataSet$activity <- activity_group

#Step 5: Create tidy data set and save to file
baseData <- melt(dataSet,(id.vars=c("subject","activity")))
tidyDataSet <- dcast(baseData, subject + activity ~ variable, mean)
write.table(tidyDataSet, "tidy_dataset.txt", sep = ",", row.names = FALSE)


