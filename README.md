# Getting_Cleaning_Data_Course_Project
This repository holds the script, tidy data set, and documentation for the Coursera Data Science Track Course "Getting and Cleaning Data."

The Dataset being used for this project is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The files contained in this repository will allow you to clean a dataset you can obtain fromt the above link. 
The script run_analysis.R will download the data set into the current working directory and will do the following
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and         each subject.

Codebook.md describes the variables, the data, and any sort of transformation made to clean the data

The final clean dataset is labled as clean_samsung_data.txt
  
