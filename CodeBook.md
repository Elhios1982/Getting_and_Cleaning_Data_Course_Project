---
title: "Code Book"
author: "Hector Hernandez"
date: "August 28, 2016"
output: html_document
---

# Overview

## Source of the original data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Full Description from the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Process
1. Obtain the dataset to be analyzed.
2. Read source files to load the data to be analyzed into tbl_df.
3. Merge test and train data sets to create a new data frame.
4. Obtain the mean and standar deviation from "features.txt" file.
5. Create the aggregate data set and sorting by "subject" and "Activity" variables.
6. Rename columns in the aggregate data set with proper variable names.
7. Write to disk the tidy data set.

## Variables
* urlFil - Contains the url for the data source.
* zipFile - Contains the filename for the data source in disk.
* zipFilePath - Indicates the path for the zip file
* dfSubjectTrain - Stores subject data for "train/subject_train.txt"
* dfSubjectTest - Stores subject data for "test/subject_test.txt"
* dfActivityTrain - Stores activity data for "train/y_train.txt"
* dfActivityTest - Stores activity data for "test/y_test.txt"
* dfTrain - Stores data files for "train/X_train.txt"
* dfTest - Stores data files for "test/X_test.txt"
* dfFeatures - Stores table with the names of features that will become the variables in the data set. Source is "features.txt""
* dfActivityLabels - Table with the activity labels. Source is "activity_labels.txt""
* dfSubjects - Holds the merged subject data for train and test tables row binding both data sets
* dfActivities - Holds the merged activity data for train and test tables row binding both data sets
* dfFeatureMeanStd
* dataAggr
* allData - Holds the aggregated, sorted and user-friendly variables data set.








