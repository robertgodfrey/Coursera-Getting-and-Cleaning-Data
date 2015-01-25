Getting and Cleaning Data Course Project Codebook
===================================================

##Data Description

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

**Of specific note is the description of data in the features_info.txt document. The following is an excerpt:**

*The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and* *tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were* *filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove *noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and* *tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.*

*Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals* *(tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the* *Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).*

*Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ,* *fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).*

*These signals were used to estimate variables of the feature vector for each pattern:* 
*'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.*

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag*

The set of variables that were estimated from these signals and were specifically used in this project are: 

mean(): Mean value  
std(): Standard deviation

##Analysis Script Description

run_analysis.R processes datasets from above link to provide a merged and cleaned dataset which has only the mean and standard deviations of measurements of test subjects.

*Note: Script assumes data from link above has been unzipped and resides in the working directory for R*

###Analysis Steps and Variable Descriptions

**Step 1.Merges the training and the test sets to create one data set.**

  * read train data, activities, and subjects into memory
  
  `train.data read from X_train.txt, contains 7352 observations of 561 variables`

  `train.activity read from y_train.txt`
  
  `train.subject read from subject_train.txt`
  
  * read test data, activities, and subjects into memory
  
  `test.data read from X_test.txt, contains 2947 observations of 561 variables`

  `test.activity read from y_test.txt`
  
  `test.subject read from subject_test.txt`
  
  * merge test and training datasets
  
  `merged.data - combined dataset which contains train.data and test.data for 10299 observations of 561 variables`

  `merged.activities combines the datasets train.activity and test.activity`
  
  `merged.subjects combines train.subject and test.subject`
  
**Step 2.Extracts only the measurements on the mean and standard deviation for each measurement.** 

  * use regular expression to extract columns with mean or std in name
  
  `grep("mean\\(\\)|std\\(\\)", features[, 2])`

  `merged.data then subsetted with extracted columns to 10299 observations of 66 variables`

**Step 3.Uses descriptive activity names to name the activities in the data set.**

  * extract descriptive names from activity_labels.txt
  
  `activities dataset is created by reading activity_labels.txt`

**Step 4.Appropriately labels the data set with descriptive variable names.**

  * finalize column labeling with subject dataset
  
  * clean column names of merged.dataset as follows:
   + remove non-alphanumeric characters
   + capitalize mean and std within column names
   + alter column prefix per features_info.txt
   
   `gsub("^t", "Time", names(merged.data)) # t prefix to Time`

   `gsub("^f", "Freq", names(merged.data)) # f prefix to Freq`
   
   `gsub("mean", "Mean", names(merged.data)) # capitalize M`
   
   `gsub("std", "Std", names(merged.data)) # capitalize S`
   
   `gsub("\\(\\)", "", names(merged.data)) # remove "()"`
   
   `gsub("-", "", names(merged.data)) # remove "-" in column names`
   
  * merge data, activties, and subject data into a tidy dataset with descriptive column names

**Step 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

  * script produces outputs below in the working directory using the `write.table()` command:
  
   + `tidy.txt` - dataset of subjects, activities and observations with descriptive column names
   
   + `tidyMeans.txt` - subset of tidy.txt that contains the averages of the measurements by subject and activity
