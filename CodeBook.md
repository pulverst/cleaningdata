Code Book
=========

##Step 1: Download and unzip

The data ZIP is downloaded to the current working directory (WD) and extracted only if iyt does not exist. You initiate a fresh download by deleting the downloaded ZIP.
The ZIP file is unzipped to the WD.

##Step 2: Load R libraries

For this script file, the reshape2 library is needed.

##Step3: Create data tables

Load all needed data into data tables

##Step 4: Tidy data

Merge training and test tables and extract only mean and std measurements. Name activities and lable the data with descriptive variable names.

##Step 5: Create and save an independent data set

Store tidy dataset to tidy_dataset.csv

