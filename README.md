Coursera: Getting and Cleaning Data
Class Project
Tim Judson
July 2014



1. Download and Unzip
The orginal file for this project was downloaded from :

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and then unzipped.


2. Read in the files to work with

The following files are needed to complete this assignment

"UCI HAR Dataset/features.txt" (read into data table: features)
"UCI HAR Dataset/activity_labels.txt" (read into data table: activities)
"UCI HAR Dataset/train/subject_train.txt" (read into data table: subject.train)
"UCI HAR Dataset/test/subject_test.txt" (read into data table: subject.test)
"UCI HAR Dataset/test/y_test.txt" (read into data table: y.test)
"UCI HAR Dataset/test/X_test.txt" (read into data table: x.test)
"UCI HAR Dataset/train/y_train.txt" (read into data table: y.train)
"UCI HAR Dataset/train/X_train.txt" (read into data table: x.train)

The relationship between the data tables is as follows:

TEST
Subject Test  2,947 obs	1 col		Who performed the action (e.g. subject 1, subjext 2, etc)
Y Test		2,497 obs	1 col		What action did they take (e.g. walk, sit, etc)
x Test		2,497 obs	561 col		Readings fron the actions (the data)

TRAIN
Subject Train	7,352 obs	1 col		Who performed the action (e.g. subject 1, subjext 2, etc)
Y Train		7,352 obs	1 col		What action did they take (e.g. walk, sit, etc)
x Train		7,352 obs	561 col		Readings fron the actions (the data)


"features" describes each of the actions (n = 561)
"activities" describes the lables for each of the 6 activities



3. Merge the Test and Train data sets together into one file

First step in thsi section is to cobine the columns for the Test and Train groups. The
result will be two data frames (test.combined and train combined). Each wll have 563 columns.
test.combined will still ahve 2,947 obs; train.combined will ahve 7,352 obs.

Next, added a column (group) to each data frame to indicate if a row was from the test or train group.
This was not specifically requested in the instructions for the project. However, I wanted to 
maintain that information with each record. It seemed to be an important attribute of the 
observations and should be retained. 

Finally, in this step, combine the two data frames into one ("combined") containing 563 columns
and 10,299 obs. 


4. Extracts only the measurements on the mean and standard deviation for each measurement. 

I've interperted this as only those measurements that are a calculated mean or std of the measurement.
In other words, only those variables that are a mean of a measurement, not a mean of another 
descriptive statistic of that measurement such as the mean frequency of a measurement.
For example, fBodyBodyAccJerkMag-mean() was extracted, fBodyBodyAccJerkMag-meanFreq() was not.

Using grep(), I've extracted 66 colums are related to mean() or std(). In addition to the 3 other 
columns (group, subject and label, the "extract" data frame now has 69 columns and 10,299 obs.


5. Update the activities in the data set with descriptive names
The raw data included a number (1 - 6) to indicate the activity performed for each measurement.
This step replaces the 1-6 numbering with the corresponding descriptions from the 
activities table.




6. Descriptive Variable Names
The raw data included variable names for measurements that contained probematic characters as well
as abbreviations that may be confusing to users. I have attempted to clarify these with the 
following changes:

column 2 changed to "subject"
column 3 changes to "activity"
any variable that starts with "f", repalced with Frequency Frequency"
any variable that starts with "t", replaced with "Time"
any variable that contained "std()-",replaced with "StandardDeviation"
any variable that contained "-std()", replaced with "StandadDeviation"
any variable that contained "-mean()-", replaced with "Mean"
any variable that contained "-mean()", replaced with "Mean"
any variable that contained "Acc", repalced with "Acceleration"
any variable that contained "Mag", replaced with "Magnitude"
any variable that contaned "BodyBody" replaced with "Body" (this appears to have been a mistake in the original variable)

NOTE: Due to the length of the resulting varibale names, I have elected to use CamelCase
to make the names mroe readable. 




7. Create tidy data set with the average of each variable for each activity and each subject.

The final step ius to summarize the average for each combination of Subject/Activity/Measurement.
This was a two-step process:

- Using the melt function (library = reshape2), melted the data for all measuement columns
against both Subject and Activity.
- Using the dcast function (library = reshape2), cast Subject + Activity against the average of
each of the measurements. 

This created a data set as follows:

   subject activity timeBodyAccelerationMeanX timeBodyAccelerationMeanY
         1        1                 0.2773308              -0.017383819
         1        2                 0.2554617              -0.023953149
         1        3                 0.2891883              -0.009918505
         1        4                 0.2612376              -0.001308288
         1        5                 0.2789176              -0.016137590
         1        6                 0.2215982              -0.040513953
         2        1                 0.2764266              -0.018594920
etc.

Since each subject in both the Test and Train group performed each activity (30 subjects and 
6 activities, there are a total of 180 rows in the final data set.





Full description of experiment where data was collected is available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



Original Data Source Location:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


This ZIP file includes the following files:

						     File Name   Length                Date
                           UCI HAR Dataset/activity_labels.txt       80 2012-10-10 15:55:00
                                  UCI HAR Dataset/features.txt    15785 2012-10-11 13:41:00
                             UCI HAR Dataset/features_info.txt     2809 2012-10-15 15:44:00
                                    UCI HAR Dataset/README.txt     4453 2012-12-10 10:38:00
                                         UCI HAR Dataset/test/        0 2012-11-29 17:01:00
                        UCI HAR Dataset/test/Inertial Signals/        0 2012-11-29 17:01:00
     UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt  6041350 2012-11-29 15:08:00
     UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt  6041350 2012-11-29 15:08:00
     UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt  6041350 2012-11-29 15:08:00
    UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt  6041350 2012-11-29 15:09:00
    UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt  6041350 2012-11-29 15:09:00
    UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt  6041350 2012-11-29 15:09:00
    UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt  6041350 2012-11-29 15:08:00
    UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt  6041350 2012-11-29 15:09:00
    UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt  6041350 2012-11-29 15:09:00
                         UCI HAR Dataset/test/subject_test.txt     7934 2012-11-29 15:09:00
                               UCI HAR Dataset/test/X_test.txt 26458166 2012-11-29 15:25:00
                               UCI HAR Dataset/test/y_test.txt     5894 2012-11-29 15:09:00
                                        UCI HAR Dataset/train/        0 2012-11-29 17:01:00
                       UCI HAR Dataset/train/Inertial Signals/        0 2012-11-29 17:01:00
   UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt 15071600 2012-11-29 15:08:00
   UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt 15071600 2012-11-29 15:08:00
   UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt 15071600 2012-11-29 15:08:00
  UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt 15071600 2012-11-29 15:09:00
  UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt 15071600 2012-11-29 15:09:00
  UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt 15071600 2012-11-29 15:09:00
  UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt 15071600 2012-11-29 15:08:00
  UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt 15071600 2012-11-29 15:08:00
  UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt 15071600 2012-11-29 15:08:00
                       UCI HAR Dataset/train/subject_train.txt    20152 2012-11-29 15:09:00
                             UCI HAR Dataset/train/X_train.txt 66006256 2012-11-29 15:25:00
                             UCI HAR Dataset/train/y_train.txt    14704 2012-11-29 15:09:00



The run_analysis.R script uses the followig files as inputs and reads them into the 
associated variables:

        			     File Name   Length   Script Variable
           UCI HAR Dataset/activity_labels.txt       80        activities
                  UCI HAR Dataset/features.txt    15785          features
         UCI HAR Dataset/test/subject_test.txt     7934      subject.test
               UCI HAR Dataset/test/X_test.txt 26458166            x.test
               UCI HAR Dataset/test/y_test.txt     5894            y.test
       UCI HAR Dataset/train/subject_train.txt    20152     subject.train
             UCI HAR Dataset/train/X_train.txt 66006256           x.train
             UCI HAR Dataset/train/y_train.txt    14704           y.train





Original Source:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - Universit√  degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition '@' smartlab.ws 
www.smartlab.ws 



Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person 
performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear 
acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label 
the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was 
selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in 
fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has
 gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and 
gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff 
frequency was used. From each window, a vector of features was obtained by calculating variables from the time and 
frequency domain. 
