---
title: "CodeBook"
author: "Brian High"
date: "Sunday, November 23, 2014"
output: html_document
---

# Code Book

This code book describes the original data set, which is also referred to as the "raw" data in this document. It also describes what was done to "tidy" these data in order to produce data sets required for this course project.

## The original data set

The raw data from the [research project web site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) contains the following high-level description of the data set:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

# License of original data set

From the README.txt provided with the original raw data set:

    Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

    [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

    This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

    Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


# Files in the original data set

The original data set contains these files:

```
UCI HAR Dataset/activity_labels.txt
UCI HAR Dataset/features.txt
UCI HAR Dataset/features_info.txt
UCI HAR Dataset/README.txt
UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt
UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt
UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt
UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt
UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt
UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt
UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt
UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt
UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/tidy_means.txt
UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt
UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt
UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt
UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt
UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt
UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt
UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt
UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt
UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt
```

The files consist of documentation and data files. The data files consist of some files containing labels and column (variable) names and other files containing data values. The data values consist of subject numbers (30), activity types (6), coded as the integers 1-6 (with corresponding text values stored separately), and sensor signals, from a 561-column "feature vector". 

The data set is split betweem two folders, "test" and "train". According to the documentaion provided with the raw data set, this partition was made randomly. For this clean-up project, we will combine these into a single data set.

## Processing

This data clean-up project requires that the "test" and "train" data set are combined into a single data set. Another requirement of this clean-up is to include "only the measurements on the mean and standard deviation for each measurement".

Since only 66 of these "features" contain the mean and standard deviation values we are interested in, the rest of the "features" were removed from the data set during processing. 

Further, since the "Inertial Signals" files do not contain mean and standard deviation values, these files were ignored for this project.

Therefore, of the remaining raw files:

```
UCI HAR Dataset/activity_labels.txt
UCI HAR Dataset/features.txt
UCI HAR Dataset/features_info.txt
UCI HAR Dataset/README.txt
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt
```

The data files are:

```
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt
```

Where:

* "test" and "train" are the folders containing the two partitions of the data
* subject_test.txt and subject_train.txt are the files of subject numbers
* X_test.txt and X_train.txt are the files of "feature vector" data
* y_test.txt and y_train.txt are the files of activity codes (1-6). 

All three "test" files used have 2947 lines. The "train" files have 7352 lines.

The label and column-heading (variable name) files are

```
UCI HAR Dataset/activity_labels.txt
UCI HAR Dataset/features.txt
```
Where:

* activity_labels.txt are the six labels for the subject's activities
* features.txt are the 561 variable names of the "feature vector"

And the documentation files are:

```
UCI HAR Dataset/features_info.txt
UCI HAR Dataset/README.txt
```

Where:

* README.txt introduces and describes the higher-level properties of the files
* features_info.txt describes in detail the "feature vector" data set

### Processing the "feature vector"

The features_info.txt file decodes the variable names for the "features".

The 66 variable names we use in this project are:

```
tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-mean()
tBodyAccMag-std()
tGravityAccMag-mean()
tGravityAccMag-std()
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()
tBodyGyroMag-mean()
tBodyGyroMag-std()
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyAccMag-mean()
fBodyAccMag-std()
fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMag-std()
fBodyBodyGyroMag-mean()
fBodyBodyGyroMag-std()
fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMag-std()
```

When imported into R, the "-", "(", and ")" characters are changed into dots "." and these dots are subsequently removed in R using gsub() calls. Further "mean" and "std" are capitalized to "Mean" and "Std", so the "features" variables become:

```
tBodyAccMeanX
tBodyAccMeanY
tBodyAccMeanZ
tBodyAccStdX
tBodyAccStdY
tBodyAccStdZ
tGravityAccMeanX
tGravityAccMeanY
tGravityAccMeanZ
tGravityAccStdX
tGravityAccStdY
tGravityAccStdZ
tBodyAccJerkMeanX
tBodyAccJerkMeanY
tBodyAccJerkMeanZ
tBodyAccJerkStdX
tBodyAccJerkStdY
tBodyAccJerkStdZ
tBodyGyroMeanX
tBodyGyroMeanY
tBodyGyroMeanZ
tBodyGyroStdX
tBodyGyroStdY
tBodyGyroStdZ
tBodyGyroJerkMeanX
tBodyGyroJerkMeanY
tBodyGyroJerkMeanZ
tBodyGyroJerkStdX
tBodyGyroJerkStdY
tBodyGyroJerkStdZ
tBodyAccMagMean
tBodyAccMagStd
tGravityAccMagMean
tGravityAccMagStd
tBodyAccJerkMagMean
tBodyAccJerkMagStd
tBodyGyroMagMean
tBodyGyroMagStd
tBodyGyroJerkMagMean
tBodyGyroJerkMagStd
fBodyAccMeanX
fBodyAccMeanY
fBodyAccMeanZ
fBodyAccStdX
fBodyAccStdY
fBodyAccStdZ
fBodyAccJerkMeanX
fBodyAccJerkMeanY
fBodyAccJerkMeanZ
fBodyAccJerkStdX
fBodyAccJerkStdY
fBodyAccJerkStdZ
fBodyGyroMeanX
fBodyGyroMeanY
fBodyGyroMeanZ
fBodyGyroStdX
fBodyGyroStdY
fBodyGyroStdZ
fBodyAccMagMean
fBodyAccMagStd
fBodyBodyAccJerkMagMean
fBodyBodyAccJerkMagStd
fBodyBodyGyroMagMean
fBodyBodyGyroMagStd
fBodyBodyGyroJerkMagMean
fBodyBodyGyroJerkMagStd
```

Decoding the abbreviated variables names can be accomplished using this key prepared by a careful study of the features_info.txt file of the original data set:

* t = time
* f = frequency
* Body = body
* Gravity = gravity
* Acc = accelerometer
* Gyro = gyroscope
* Jerk = jerk, derived from body measurements
* X = x-axis
* Y = y-axis
* Z = z-axis
* Mag = magnitude
* Mean = mean value
* Std = standard deviation

Further explanations of the variable naming scheme can be found in the features_info.txt file of the original data set.

### "Features" - values and units

From the README.txt provided with the original raw data set:

* Body acceleration = total acceleration - gravity
* Acceleration: standard gravity units 'g'
* Gyroscope: radians/second
* All features: normalized and bounded within [-1,1]

## Running the run_analysis.R script

The run_analysis.R script unzips the ZIP data files, then proceeds to import the data files of interest into data frames and tidy the data as per the assignment.

The steps performed by the script are further described in more detail below.

### Extracting the raw data files

The run_analysis.R script extracts the ZIP file containing all data files using unzip(), then the data folder is entered using setwd().

### Importing the data

Importing is performed using read.table(). Column names are assigned with col.names. Further data tidying of column names is performed using gsub(). 

### Processing the "features"

The "test" and "train" data "features" were imported and tidied as described above. Other than applying column names to the "features" variables and cleaning-up those names, and removing the variables which were not of interest (no means or standard deviations), no other transformations were performed. Therefore, the "wide" format was used, meaning that there is a column for every "feature" variable that is a mean or standard deviation and also that there is only one value for each variable in each row. This is one of the forms of tidy data acceptable for this assignment. The other is "narrow" format, which would list the features as values of a "signals" column or similar.

### Processing the subjects and activites

The two "subject" and "activity" variables have been included in the tidy data sets, and can be further described as:

* subject (integers, 1-30)
* activity (6 string labels used as factors in R)

Activity labels are assigned using factor(). 

### User-defined functions

All of these data tidying operations are performed within user-defined functions in order to reuse code and to aid organization and readability. These functions come before the "Main Routine" section and are well commented.

### Combining the data sets

The 66 numerical variables of the "features" data set were combined with the "activites" labled as factors, and integer "subjects" data using cbind() to produce 68-variable "test" and "train" data sets.

The "test" and "train" data sets were further combined with rbind() to produce the 10299-row "tidy" data set. Finally, an aggregated "tidy_means" data set with 180 rows was produced using aggregate().

### Result Data Sets

The resulting data sets are summarized as follows:

* tidy
* tidy_means

Where "tidy" is the 10299-row combined data set with cleaned-up column names and labels, and only the mean and standard deviation values from the "feature vector" data.

"tidy_means" is the aggregated data set, grouped by subject and activity, producing a 180-row data frame. 

Both data sets have 68 columns.

"tidy_means" is exported as a text file, "tidy_means.txt" and is written to the "UCI HAR Dataset" folder.

This file can be imported and viewed with these commands:

    data <- read.table("tidy_means.txt", header = TRUE)
    View(data)
