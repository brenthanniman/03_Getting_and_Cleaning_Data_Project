## Getting and Cleaning Data - Course Project

## This R Script generates a tidy data set from data collected from Samsung Galaxy S accelerometers
## The original data was obtained from: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## The raw data can be found at the following URL:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Check to see if the file to download has already been downloaded, if not, then download it
if (!file.exists("Dataset.zip")) {
  ## Download the file and unzip it
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                  destfile = "Dataset.zip", method = "curl") 
  unzip("Dataset.zip", exdir=".")
} else {
  ## File has already been downloaded, let the user know you are using the stored copy
  message("Data already downloaded. Using stored Copy")
}  

## Read-in activity labels and features
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("index","activity_label"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("index","feature_name"))

## Load test set and combine into 1 data frame
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity")
test_readings <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$feature_name)
test_set <- cbind(test_subject, test_activity, test_readings)

## Load training set and combine into 1 data frame
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity")
train_readings <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$feature_name)
train_set <- cbind(train_subject, train_activity, train_readings)

## Merge the two tables together
complete_set <- rbind(test_set, train_set)

## Select only those features that represent mean and standard deviation
mean_features <- grep("mean()", names(complete_set))
std_features <- grep("std()", names(complete_set))

## Extract only the measurements on mean and standard deviation of each measurement
library(dplyr)
subset <- complete_set %>%
  select(subject, activity, mean_features, std_features)

## Replace the activity indices with descriptive names
for (i in 1:6) {subset$activity <- sub(activity_labels$index[i],activity_labels$activity_label[i], subset$activity)}

## Give a meaningful name to the dataset
tidy_dataset_mean_std <- subset

## Write dataset to file
write.table(tidy_dataset_mean_std, "tidy_dataset_mean_std.txt", row.name=FALSE)

## Provide an independet tidy data set with the average of each variable for each activity and each subject
tidy_dataset_mean_std_averages <- tbl_df(tidy_dataset_mean_std)
tidy_dataset_mean_std_averages <- tidy_dataset_mean_std_averages %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

## Write dataset to file
write.table(tidy_dataset_mean_std_averages,"tidy_dataset_mean_std_averages.txt", row.name=FALSE)