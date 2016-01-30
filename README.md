# Getting and Cleaning Data Project

This R Script: run_analysis.R generates a tidy data set from data collected from Samsung Galaxy S accelerometers.
The original data can be found at the UCI Machine Learning Repository website: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data can be found at the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script follows the following steps to generate the tidy data set:

1. Retrieves the data
  + Downloads the dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  + Unzips the raw data

2. Reads in the required activity and feature labels and stores them in vectors 
  + Activity labels: ./UCI HAR Dataset/activity_labels.txt
  + Feature labels: ./UCI HAR Dataset/features.txt

3. Generates a data frame of the test measurements: test_set
  + Loads the subject measurments from: ./UCI HAR Dataset/test/subject_test.txt
  + Loads the activity reference indices for hte measurements from : ./UCI HAR Dataset/test/y_test.txt
  + Loads the feature measurements from: ./UCI HAR Dataset/test/X_test.txt
  + Column binds the individual vectors into one data frame

4. Generates a data frame of the training measurements: train_set
  + Loads the subject measurments from: ./UCI HAR Dataset/train/subject_train.txt
  + Loads the activity reference indices for hte measurements from : ./UCI HAR Dataset/train/y_train.txt
  + Loads the feature measurements from: ./UCI HAR Dataset/train/X_train.txt
  + Column binds the individual vectors into one data frame

5. Merge the test and training sets together into one data frame: complete_set

6. Subset the data frame for just mean and standard deviation measurements: subset
  + Selected all features whose labels contained mean or std

7. Replace the numerical activity indices in the ativity variable with the decriptive activity labels from activity_labels.txt

8. Stored the resulting tidy data in a new data frame: tidy_dataset_mean_std

9. Generated a new data set with the average of each variable for each activity and each subject: tidy_dataset_mean_std_averages
