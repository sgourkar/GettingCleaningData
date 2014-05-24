# Getting and Cleaning Data - Course Project

# Load training set data:
subjects <- scan("subject_train.txt")
activityLabels <- scan("y_train.txt")
train <- read.table("X_train.txt")
features <- read.table("features.txt")


# Label 'train' field names using 'features':
features <- features[,-1]
features <- as.character(features)
names(train) <- features

# Add activity labels to training set:
# Change activityLabels to be a 
# character vector
activityLabels <- as.character(activityLabels)
activityLabels <- mapvalues(activityLabels, c("1", "2", "3", "4", "5", "6"), 
                            c("walking", "walking_upstairs", 
                              "walking_downstairs", "sitting", "standing", 
                              "laying"))

# Add activityLabels to the 'train' dataset
train$activity <- activityLabels

# Add subject label to the 'train' dataset:
train$subject <- subjects
train <- train[,c(563,1:562)]

# The training dataset 'train' is assembled. Now to assemble the 'test' dataset:
test <- read.table("X_test.txt")
testSubjects <- scan("subject_test.txt")
testActivityLabels <- scan("y_test.txt")
names(test) <- features

testActivityLabels <- mapvalues(testActivityLabels, 
                                c("1", "2", "3", "4", "5", "6"), 
                                c("walking", "walking_upstairs", 
                                  "walking_downstairs", "sitting", 
                                  "standing", "laying"))
test$activity <- testActivityLabels
test$subject <- testSubjects
test <- test[,c(563,1:562)]

# Merge the two datasets:
complete <- join(train, test, by = "subject", type = "full")

# Extract measurements on mean and standard deviation:
meanFields <- grep("mean", names(complete), ignore.case = T)
stdFields <- grep("std", names(complete), ignore.case = T)
meanStdSubset <- complete[,c(1,563, meanFields, stdFields)]

# Get mean of each measurement variable in this dataset:
sapply(meanStdSubset, mean)
