# --------------------------------------------------------------------------
# Filename: run_analysis.R
# Author: Brian High
# Assignment: Term Project
# Course: Getting Data, Coursera
# Course URL: https://class.coursera.org/getdata-009
# Last Modified: 2014-11-23
# Due: Before 2014-11-23, 23:30 UTC (3:30 PM PST)
# --------------------------------------------------------------------------
#
# Instructions for this Assignment:
# 
# You should create one R script called run_analysis.R that does the following.
#
# (Quoted from the "submissions" page from the course website, see URL above.)
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#    Export as a txt file created with write.table() using row.name=FALSE.
#
# In the code below, satifaction of these requirements will be identified
# in comments as "** Requirement **".
#
# Tidy data principles:
#
# Each variable you measure should be in one column, Each different 
# observation of that variable should be in a different row
#
# Repo requirements:
#
# Please submit a link to a Github repo with the code for performing your 
# analysis. The code should have a file run_analysis.R in the main directory 
# that can be run as long as the Samsung data is in your working directory. 
# The output should be the tidy data set you submitted for part 1. You should 
# include a README.md in the repo describing how the script works and the code 
# book describing the variables.
# 
# Code book requirements:
#
# Modifies and updates the codebooks available to you with the data to 
# indicate all the variables and summaries you calculated, along with units, 
# and any other relevant information
#
# README requirements:
#
# Explains what the analysis files do.
# 
# Here are the data for the project:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# A full description is available at the site where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# Additional Resources:
#
# * David's Project FAQ in the course forum:
#
#     https://class.coursera.org/getdata-009/forum/thread?thread_id=58
#
# * Tidy data discussion in the course forum:
#
#     https://class.coursera.org/getdata-009/forum/thread?thread_id=192
#
# Per the assignment, assume the raw data file has already been downloaded.
#
# destFile = "uci-har-dataset.zip"
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl, destfile = destFile, method = "curl")
#
# --------------------------------------------------------------------------

# ---------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------

# Use functions for code reuse of data import and preparation routines.
# See the "Main Routine" below for the beginning of processing.

# -----------------------------------------------------
# Import "features" column names for 561-feature vector
# -----------------------------------------------------
importFeaturesColumnNames <- function(filename){
    df <- read.table(filename, header = FALSE, 
                     stringsAsFactors = FALSE,
                     col.names = c("number", "name"))
    return(df$name)
}

# -------------------------
# Import 561-feature vector
# -------------------------
importFeatures <- function(filename, colnames){
    # Read text file into data frame
    df <- read.table(filename, header = FALSE, sep = "", 
                         stringsAsFactors = FALSE, col.names = colnames)
    
    # Remove all columns except mean() & std() columns 
    #
    # ** Requirement **
    #
    # 2. Extracts only the measurements on the mean and standard deviation 
    #    for each measurement.
    #
    df <- df[, grep("[.](mean|std)[.]", colnames(df))]

    # ** Requirement **
    #
    # 4. Appropriately labels the data set with descriptive variable names.
    #
    # See also use of colnames= in importSubjects() and importActivities()
    #
    # Clean up column names: remove dots (.) and capitalize Mean and Std
    names(df) <- gsub("[.]", "", names(df))
    names(df) <- gsub("mean", "Mean", names(df))
    names(df) <- gsub("std", "Std", names(df))
    
    return(df)
}

# ----------------------
# Import activity labels
# ----------------------
#
# ** Requirement **
#
# 3. Uses descriptive activity names to name the activities in the data set
#
# See: "Set activity labels as factor labels" in importActivities() function.
#
importActivityLabels <- function(filename){
    # Read text file into data frame
    df <- read.table("activity_labels.txt", header = FALSE, 
                     stringsAsFactors = FALSE, 
                     col.names = c("level", "label"))
    
    return(df)
}

# -----------------
# Import activities
# -----------------
importActivities <- function(filename, factors){
    # Read text file into data frame
    df <- read.table(filename, header = FALSE, sep = "", 
                     stringsAsFactors = FALSE, col.names = c("activity"))
    
    # Set activity labels as factor labels
    #
    # ** Requirement **
    #
    # 4. Appropriately labels the data set with descriptive variable names.
    #
    # See also use of colnames= in importSubjects() and importFeatures()
    #
    df$activity <- factor(df$activity, 
                          levels = factors$level, labels = factors$label)
    
    return(df)
}


# Import subjects
importSubjects <- function(filename){
    # Read text file into data frame
    df <- read.table(filename, header = FALSE, sep = "", 
                     stringsAsFactors = FALSE, col.names = c("subject"))
    
    return(df)
}

# ---------------------------------------------------------------------
# Main Routine
# ---------------------------------------------------------------------

# Extract data (assume already in current working folder, per assignment)
unzip("uci-har-dataset.zip")

# Set dataset folder as working directory
setwd("./UCI HAR Dataset")

# Import text data files and do preliminary clean up on columns and factors
features <- importFeaturesColumnNames("features.txt")
features_train <- importFeatures("train/X_train.txt", features)
features_test <- importFeatures("test/X_test.txt", features)
activities <- importActivityLabels("activity_labels.txt")
activities_train <- importActivities("train/y_train.txt", activities)
activities_test <- importActivities("test/y_test.txt", activities)
subjects_train <- importSubjects("train/subject_train.txt")
subjects_test <- importSubjects("test/subject_test.txt")

# --- Combining the data sets into a single data frame ----
#
# Combine features, activities, and subjects data frames
train <- cbind(features_train, activities_train, subjects_train)
test <- cbind(features_test, activities_test, subjects_test)
#
# Combine train and test data frames into a single data frame
#
# ** Requirement **
#
# 1. Merges the training and the test sets to create one data set.
#
# NOTE: The tidy dataset is of the "wide" format -- where the "signals"
#       each have their own colmn name. This is one acceptable variation
#       for this assignment. The other variation is the long (narrow) format
#       where signals would be listed by row, as values of a "signals" column.
#
# From the "submissions" page for this assignment:
#
#       Either a wide or a long form of the data is acceptable if it meets the 
#       tidy data principles of week 1 (Each variable you measure should be in 
#       one column, Each different observation of that variable should be in a 
#       different row).
#
# In the case of the "wide" form, each signal is a variable, and each 
# row contains a single observation of each variable.
# 
tidy <- rbind(train, test)

# ** Requirement **
#
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#
# Create tidy data frame of means of each variable, aggregated by
# activity and subject. Calculate means on only the first 66 columns, 
# ignoring the two aggregate-by columns, activity and subject.
tidy_means <- with(tidy, aggregate(tidy[,1:66], 
                                   by=list(activity=activity, subject=subject), 
                                   FUN=mean))

# ** Requirement **
#
# Export as a txt file created with write.table() using row.name=FALSE.
#
# Export this data frame to a text file
write.table(tidy_means, file="tidy_means.txt", row.names=FALSE)

# For users of this data set: To Import and view in R, run these commands ...
#data <- read.table("tidy_means.txt", header = TRUE)
#View(data)