#setwd("~/Coursera_GettingandCleaningData/Project/UCI HAR Dataset")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Step 1. Merge the training and test sets to create one data set
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# read training data, labels, and subjects into variables
train.data <- read.table("train/X_train.txt")  # 7352 observations of 561 variables
train.activity <- read.table("train/y_train.txt")
train.subject <- read.table("train/subject_train.txt")

# read test data, labels, and subjects into variables
test.data <- read.table("test/X_test.txt")  # 2947 observations of 561 variables
test.activity <- read.table("test/y_test.txt")
test.subject <- read.table("test/subject_test.txt")

# merge test and training datasets
merged.data <- rbind(train.data, test.data) # 10299 observations of 561 variables
merged.activities <- rbind(train.activity, test.activity)
merged.subjects <- rbind(train.subject, test.subject)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Step 2. Extract mean and standard deviation for each measurement
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# read observation variables 
features <- read.table("features.txt")

# use reg exp to extract columns with mean() or std() in their names
features.mean.std <- grep("mean\\(\\)|std\\(\\)", features[, 2])

# subset merged data to the extracted columns
merged.data <- merged.data[, features.mean.std] # 10299 observations of 66 variables

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Step 3. Use descriptive activity labels to name the activities in the data set
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# read descriptive activity labels
activities <- read.table("activity_labels.txt")

# update merged.labels with descriptive activity names
merged.activities[, 1] <- activities[merged.activities[, 1], 2]

# correct column names
names(merged.activities) <- "Activity"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Step 4. Appropriately label the data set with descriptive variable names
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# correct column name for subject data
names(merged.subjects) <- "Subject"

# set column names, remove non-alpha characters and alter prefix per features_info.txt
names(merged.data) <- features[features.mean.std, 2]
names(merged.data) <- gsub("^t", "Time", names(merged.data)) # t prefix to Time
names(merged.data) <- gsub("^f", "Freq", names(merged.data)) # f prefix to Freq
names(merged.data) <- gsub("mean", "Mean", names(merged.data)) # capitalize M
names(merged.data) <- gsub("std", "Std", names(merged.data)) # capitalize S
names(merged.data) <- gsub("\\(\\)", "", names(merged.data)) # remove "()"
names(merged.data) <- gsub("-", "", names(merged.data)) # remove "-" in column names 

# bind all the data in a single data set
tidy.data <- cbind(merged.subjects, merged.labels, merged.data)

# write tidy dataset to text file
write.table(tidy.data, "tidy.txt", row.name=FALSE)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Step 5. Create an independent tidy data set with the average of each variable
# for each activity and each subject
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# need plyr library for processing
if(!is.element("plyr", installed.packages()[,1])){
    print("Installing packages")
    install.packages("plyr")
}
library(plyr)

# get colMeans by activity and subject
tidy.means <- ddply(tidy.data, .(Subject, Activity), function(x) colMeans(x[, 3:68]))

# write final output of averages to tidyMeans.txt
write.table(tidy.means, "tidyMeans.txt", row.name=FALSE)
