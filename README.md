# Getting and cleaning data Course

For creating a tidy data set of wearable computing data originally from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Files in this repository
* README.md
* CodeBook.md -> codebook describing the variables, the data and transformations
* run_analysis.R -> the R code

## What is the run_analysis.R
You should create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

It should run in a folder of the Samsung data, this folder contains the subfolder UCI HAR Dataset
* activity_labels.txt
* features.txt
* test/
* train/

The output file will be created on working directory : of tidy_base.txt


* Step 1:
  * reading all the data and put all in the data to use later

* Step 2:
  * Reading the feature base
  * Keep only the features of mean and standard deviation
  * Keep only the means and standard deviations inc by 2, data has subs and labels in the top

* Step 3:
  * Get the labels of the activities
  * Put the labeles in the data

* Step 4:
  * Creating a list with the columna names and feat names
  * Remove every invalid character and put in lowercase
  * Using the list as column name
  
* Step 5:
  * Get each mean combination 
  
* Final step:
  * Write the new tidy set into a text file called tidy2.txt, formatted similarly to the original files.