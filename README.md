Getting and Cleaning Data Course Project
========================================
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Analysis Script Description

**run_analysis.R processes datasets from above link to provide a merged and cleaned dataset which has only the mean and standard deviations of measurements of test subjects.**

*Note: Script assumes data from link above has been unzipped and resides in the working directory for R*

#Analysis Steps
Step 1.Merges the training and the test sets to create one data set.
  + read test data, labels, and subjects into memory
  + read test data, labels, and subjects into memory
  + merge test and training datasets into merged datasets

Step 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

Step 3.Uses descriptive activity names to name the activities in the data set.

Step 4.Appropriately labels the data set with descriptive variable names. 

Step 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.