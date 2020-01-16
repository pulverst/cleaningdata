#R script for Peer-graded Assignment: Getting and Cleaning Data Course Project

#Sources
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

#unzip if not dirName does not exist
if(!file.exists(dirName)){
  unzip(fileName, files = NULL, exdir=".")
}



