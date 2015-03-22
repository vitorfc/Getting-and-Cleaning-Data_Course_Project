## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

setwd("c:/R")

## 1
# reading all the data
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="label")
test_subs <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subject")
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="label")
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subject")
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")

# put all in the data to use later
data <- rbind(cbind(test_subs, test_labels, test_data),
              cbind(train_subjects, train_labels, train_data))

## 2
# reading the feature base
features <- read.table("./UCI HAR Dataset/features.txt", 
                       strip.white=TRUE, 
					   stringsAsFactors=FALSE)
# keep only the features of mean and standard deviation
feat_mean_std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

# keep only the means and standard deviations inc by 2, data has subs and labels in the top
data_mean_std <- data[, c(1, 2, feat_mean_std$V1+2)]

## 3
# get the labels of the activities
labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
# put the labeles in the data
data_mean_std$label <- labels[data_mean_std$label, 2]

## 4
# creating a list with the columna names and feat names
good.colnames <- c("subject", "label", feat_mean_std$V2)

# remove every invalid character and put in lowercase
good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames))

# using the list as column name
colnames(data_mean_std) <- good.colnames

## 5
# get each mean combination 
aggr.data <- aggregate(data_mean_std[, 3:ncol(data_mean_std)],
                       by=list(subject = data_mean_std$subject, label = data_mean_std$label),mean)

write.table(format(aggr.data, scientific=T), "tidy_base.txt",
            row.names=F, col.names=F, quote=2, row.name=FALSE)