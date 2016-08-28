library(dplyr)
library(data.table)
library(tydr)

setwd("C:/Users/h.hernandez.ortega/OneDrive - Accenture/01_Documents/02_Accenture/03_Training/05_Data Science Specialization/Getting and Cleaning Data/Code")

urlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(urlFile,"./wearable-dataset.zip")
zipFile <- "./wearable-dataset.zip"
unzip(zipFile, overwrite = TRUE)

zipFilePath <- "./UCI HAR Dataset"

# Subject files
dfSubjectTrain <- file.path(zipFilePath, "train", "subject_train.txt") %>% 
                    read.table() %>% 
                    tbl_df()
dfSubjectTest <- file.path(zipFilePath, "test", "subject_test.txt") %>% 
                    read.table() %>%
                    tbl_df()

# Read activity files
dfActivityTrain <- file.path(zipFilePath, "train", "y_train.txt") %>% 
                    read.table() %>% 
                    tbl_df()
dfActivityTest <- file.path(zipFilePath, "test", "y_test.txt") %>% 
                    read.table() %>% 
                    tbl_df()

# Read data files
dfTrain <- file.path(zipFilePath, "train", "X_train.txt") %>% 
            read.table() %>% 
            tbl_df()
dfTest <- file.path(zipFilePath, "test", "X_test.txt") %>% 
            read.table() %>% 
            tbl_df()

# Read features files
dfFeatures <- file.path(zipFilePath, "features.txt") %>% 
                read.table() %>% 
                tbl_df() %>%
                rename(featureNum = V1, featureName = V2)

dfActivityLabels <- file.path(zipFilePath, "activity_labels.txt") %>% 
                read.table() %>% 
                tbl_df() %>%
                rename(activityNum = V1, activityName = V2)

# Merging data frames
dfSubjects <- bind_rows(dfSubjectTrain, dfSubjectTest) %>%
                rename(subject = V1)

dfActivities <- bind_rows(dfActivityTrain,dfActivityTest) %>%
                rename(activityNum = V1)
  
allData <- bind_rows(dfTrain, dfTest) 
colnames(allData) <- dfFeatures$featureName


allData <- bind_cols(dfSubjects, dfActivities) %>%
            bind_cols(allData)

# Read "features.txt" to extract the mean and std deviation
dfFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",dfFeatures$featureName,value=TRUE)

# Taking measurements for mean and standard deviation and adding "subject","activityNum" colnames

dfFeaturesMeanStd <- union(c("subject","activityNum"), dfFeaturesMeanStd)
allData <- subset(allData,select=dfFeaturesMeanStd) 

allData <- merge(dfActivityLabels, allData , by="activityNum", all.x=TRUE)
allData$activityName <- as.character(allData$activityName)

## Sortin allData with variable means by "subject" and "Activity"
allData$activityName <- as.character(allData$activityName)
dataAggr <- aggregate(. ~ subject - activityName, data = allData, mean) 
allData <- tbl_df(arrange(dataAggr,subject,activityName))

## Renaming allData with appropriate names
names(allData)<-gsub("std()", "SD", names(allData))
names(allData)<-gsub("mean()", "MEAN", names(allData))
names(allData)<-gsub("^t", "time", names(allData))
names(allData)<-gsub("^f", "frequency", names(allData))
names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))

head(str(allData),6)

## Write to txt the tidy data set
write.table(allData, "tidy-data.txt", row.name=FALSE)
