## Coursera: Getting & Cleaning Data
## Class Project
## July 2014

## Overview
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


## Set script environment
library(reshape2)

## Download data for project
## This step is included as it was part of the original work ont his project. It is cdommented out here
## under the assumption (stated in the project rubric), that the script shoudl function as long as 
## the Samsung Data (assuming the .ZIP file) is located in the working directory. 

## if(!file.exists("./data")){dir.create("./data")}
## fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## download.file(fileUrl,destfile="./data/SamsungGalaxyData.zip")

## Unzip the assumed-to-be-present Samsung data file (if files already upzipped, comment out this line)
unzip("./data/SamsungGalaxyData.zip")


## Read in working files
features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
y.test <- read.table("UCI HAR Dataset/test/y_test.txt")
x.test <- read.table("UCI HAR Dataset/test/X_test.txt")
y.train <- read.table("UCI HAR Dataset/train/y_train.txt")
x.train <- read.table("UCI HAR Dataset/train/X_train.txt")

## Combine the Test and Train data tables into a Test and Train combined file
test.combined <- cbind(subject.test, y.test, x.test)
train.combined <- cbind(subject.train, y.train, x.train)

## Add a column ("group" with values = test or train) to each data frame to be able to track 
## which group the subject was in (see Readme for reasoning)
test.combined <- cbind(group = "test", test.combined)
train.combined <- cbind(group = "train", train.combined)
combined <- rbind(test.combined, train.combined)  ## combine the two data sets


## Add column names for the measurement data (columns 4:564) 
collist <- as.character(features$V2)
colnames(combined)[4:564] <- collist


## Extract only columns pertaining to mean() or std() measures
## Find any variable that ends in "mean()" or "std()"

extract <- (combined[, c(1, 2, 3, 3 + (grep("*-mean\\(\\)",features$V2)), 3 + grep("*-std\\(*",features$V2))])


colnames(extract)[2] <- "subject"  ## change column name for ease of reference
colnames(extract)[3] <- "activity"  ## change column name for ease of reference


## Update the activities in the data set with descriptive names
## Replace the 1-6 numbering with the corresponding descriptions from the acti

extract$activity <- gsub("1", "Walking", as.character(extract$activity))
extract$activity <- gsub("2", "WalkingUpstairs", as.character(extract$activity))
extract$activity <- gsub("3", "WalkingDownstairs", as.character(extract$activity))
extract$activity <- gsub("4", "Sitting", as.character(extract$activity))
extract$activity <- gsub("5", "Standing", as.character(extract$activity))
extract$activity <- gsub("6", "Laying", as.character(extract$activity))
 

## Clean up variable names, making them more readable/understandable (see ReadMe for notes)

colnames(extract) <- gsub("^f", "Frequency", colnames(extract))
colnames(extract) <- gsub("^t", "Time", colnames(extract))
colnames(extract) <- gsub("-std\\(\\)-", "StandardDeviation", colnames(extract))
colnames(extract) <- gsub("-std\\(\\)", "StandardDeviation", colnames(extract))
colnames(extract) <- gsub("-mean\\(\\)-", "Mean", colnames(extract))
colnames(extract) <- gsub("-mean\\(\\)", "Mean", colnames(extract))
colnames(extract) <- gsub("Acc", "Acceleration", colnames(extract))
colnames(extract) <- gsub("Mag", "Magnitude", colnames(extract))
colnames(extract) <- gsub("BodyBody", "Body", colnames(extract))


## Find the average for each subject and acvitity

meltList <- colnames(extract)[4:69] ## find columns to melt
meltExtract <- melt(extract, id = c("subject", "activity"), measure.vars = meltList)  ## melt the data set
tidyData <- dcast(meltExtract, subject + activity ~ variable, mean )

## Update the Column Headers to indicate that each is the mean of the variable
colnames(tidyData) <- gsub("^Time", "MeanOfTime", colnames(tidyData))
colnames(tidyData) <- gsub("^Frequency", "MeanOfFrequency", colnames(tidyData))


## Write TidyData to a .csv file in the "data" directory
write.table(tidyData, "./data/TidyData.txt", sep = ",", row.names = FALSE)