# Details on the raw data used for this project

==================================================================

Human Activity Recognition Using Smartphones Dataset

Version 1.0

==================================================================

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Universit? degli Studi di Genova.

Via Opera Pia 11A, I-16145, Genoa, Italy.

activityrecognition\@smartlab.ws

www.smartlab.ws

==================================================================

This raw data set can be downloaded from the following link,

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Further Information can be obtained from the following link,

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

## Reference

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

## Feature Selection for the raw data

The measurements selected for this data come from the accelerometer and gyroscope 3-axial raw signals captured at a constant rate of 50Hz. These time domain signals are denoted by a 't' in front of them.\
The following transformations were applied to these in the database itself,

-   Both signals are detrended with a median, filtered to reduce noise
-   Acceleration signal is divided into body and gravity acceleration (tBodyAcc-XYZ & tBodyGravity-XYZ)
-   Linear acceleration and angular velocity are derived to obtain jerk signals (tBodyAccJerk-XYZ & tBodyGyroJerk-XYZ)
-   Magnitudes of these 3 dimensional signals calculated under normal distribution (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag)
-   Fourier transformation is done on some of the above signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag ('f' denotes requency domain signals)

Kindly refer to the `features_info.txt` available in the raw data for detailed explanation.\
This text file gives detailed descriptions of the features selected for these train and test datasets

### Variables estimated from the above signals

-   mean(): Mean value
-   std(): Standard deviation
-   and others which can be obtained from the above `features_info.txt`.

## Steps performed to reach the desired tidy data

1.  Download if needed and load the packages used in the R script
    -   `dplyr` package - Version 1.1.2
2.  Download the required raw data from the link provided
3.  Reading the train and test data sets
4.  Reading in the feature list corresponding to the columns of both data sets
5.  Reading in the activity labels which have been cleaned up to have no uppercase characters or special characters like '\_'
6.  Reading in the information on subject and type of activity for the 2 data sets which represent which rows belong to which combination of subject and the monitored activity
7.  Adding the feature names as column names of the 2 data sets
8.  Adding the subject and activity information to both data sets
9.  Extracting only the mean and standard deviation of each measurement
10. Merging the 2 data sets along all columns resulting into a data set stored as 'dat':
    -   rows representing all possible combinations for subject and activity being monitored
    -   columns representing either the mean or standard deviation of all the variables
    -   This data is already ordered by activity and subjects due to how the `merge()` function works
11. Variable names ie. the column names are edited using the `gsub()` and `sub()` functions to be more descriptive under the following conditions:
    -   Any occurrences of '\_', '(' AND ')' are replaced with nothing
    -   'Acc' abbreviation is extended to 'Acceleration'
    -   'Gyro' abbreviation is extended to 'Gyroscope'
    -   'Mag' abbreviation is extended to 'Magnitude'
    -   'mean' is changed to 'Mean' delineating it as a separate word
    -   'std' abbreviation is extended to 'StandardDeviation'
    -   Replace any 'BodyBody' repetitions to just 'Body'
12. Following transformation to the merged data set are made using the dplyr package version 1.1.2,
    -   Change the activity column as a vector whose labels represent descriptive names of activities being measured (`mutate()`)
    -   Change the subject column to a vector (`mutate()`)
    -   Rename the variables to be more descriptive
13. Tidy data set is created by passing the transformed 'dat' through the following pipeline of functions
    -   Group the data set by activity AND subject (`group_by()`)
    -   Summarize each column ie. each variable to a mean based on activity and subject groups

### The function `run_analysis()` in the run_analysis.R performs the above mentioned steps and returns the desired tidy data set. This function was written in,

```         
"R version 4.3.0 (2023-04-21 ucrt)"
```

# Tidy data set code book

Class: "grouped_df" "tbl_df" "tbl" "data.frame"

Dimensions: 180 rows and 68 columns

**\$activity** - a factor with self-descriptive levels representing each of the monitored activities:\
[1] "walking"\
[2] "walkingupstairs"\
[3] "walkingdownstairs"\
[4] "sitting"\
[5] "standing"\
[6] "laying"\

**\$subject** - a factor with 30 levels 1:30 representing each subject

All rows represent all the possible combinations of the above mentioned 2 groups

### Remaining columns(variables):

Each entry in the following columns represents the **mean of the variables**(described by column names) for each activity and each subject

-   X, Y and Z represent the vectors along the three x, y and z axes

-   't' represents time domain signals

-   'f' represents frequency domain signals

-   'BodyAcceleration' and 'Gravity' terms refer to Accelerometer Readings

-   'Gyroscope' term refers to Gyroscope Readings

-   'Jerk' term represents the linear(when Body Acceleration is involved) or the angular(when Gyroscope readings are involved) velocities in the concerned axis

-   All of these contain the data type double, <dbl>

For eg. the name of the column is,

"tBodyAccelerationMeanX" than it represents the Mean of mean body acceleration(time domain signal) along the x axis for each activity and each subject\
"fBodyAccelerationJerkStandardDeviationZ" represents the Mean of linear body acceleration standard deviation along the z axis for each activity and each subject

**\$tBodyAccelerationMeanX**

**\$tBodyAccelerationMeanY**

**\$tBodyAccelerationMeanZ**

**\$tBodyAccelerationStandardDeviationX**

**\$tBodyAccelerationStandardDeviationY**

**\$tBodyAccelerationStandardDeviationZ**

**\$tGravityAccelerationMeanX**

**\$tGravityAccelerationMeanY**

**\$tGravityAccelerationMeanZ**

**\$tGravityAccelerationStandardDeviationX**

**\$tGravityAccelerationStandardDeviationY**

**\$tGravityAccelerationStandardDeviationZ**

**\$tBodyAccelerationJerkMeanX**

**\$tBodyAccelerationJerkMeanY**

**\$tBodyAccelerationJerkMeanZ**

**\$tBodyAccelerationJerkStandardDeviationX**

**\$tBodyAccelerationJerkStandardDeviationY**

**\$tBodyAccelerationJerkStandardDeviationZ**

**\$tBodyGyroscopeMeanX**

**\$tBodyGyroscopeMeanY**

**\$tBodyGyroscopeMeanZ**

**\$tBodyGyroscopeStandardDeviationX**

**\$tBodyGyroscopeStandardDeviationY**

**\$tBodyGyroscopeStandardDeviationZ**

**\$tBodyGyroscopeJerkMeanX**

**\$tBodyGyroscopeJerkMeanY**

**\$tBodyGyroscopeJerkMeanZ**

**\$tBodyGyroscopeJerkStandardDeviationX**

**\$tBodyGyroscopeJerkStandardDeviationY**

**\$tBodyGyroscopeJerkStandardDeviationZ**

**\$tBodyAccelerationMagnitudeMean**

**\$tBodyAccelerationMagnitudeStandardDeviation**

**\$tGravityAccelerationMagnitudeMean**

**\$tGravityAccelerationMagnitudeStandardDeviation**

**\$tBodyAccelerationJerkMagnitudeMean**

**\$tBodyAccelerationJerkMagnitudeStandardDeviation**

**\$tBodyGyroscopeMagnitudeMean**

**\$tBodyGyroscopeMagnitudeStandardDeviation**

**\$tBodyGyroscopeJerkMagnitudeMean**

**\$tBodyGyroscopeJerkMagnitudeStandardDeviation**

**\$fBodyAccelerationMeanX**

**\$fBodyAccelerationMeanY**

**\$fBodyAccelerationMeanZ**

**\$fBodyAccelerationStandardDeviationX**

**\$fBodyAccelerationStandardDeviationY**

**\$fBodyAccelerationStandardDeviationZ**

**\$fBodyAccelerationJerkMeanX**

**\$fBodyAccelerationJerkMeanY**

**\$fBodyAccelerationJerkMeanZ**

**\$fBodyAccelerationJerkStandardDeviationX**

**\$fBodyAccelerationJerkStandardDeviationY**

**\$fBodyAccelerationJerkStandardDeviationZ**

**\$fBodyGyroscopeMeanX**

**\$fBodyGyroscopeMeanY**

**\$fBodyGyroscopeMeanZ**

**\$fBodyGyroscopeStandardDeviationX**

**\$fBodyGyroscopeStandardDeviationY**

**\$fBodyGyroscopeStandardDeviationZ**

**\$fBodyAccelerationMagnitudeMean**

**\$fBodyAccelerationMagnitudeStandardDeviation**

**\$fBodyAccelerationJerkMagnitudeMean**

**\$fBodyAccelerationJerkMagnitudeStandardDeviation**

**\$fBodyGyroscopeMagnitudeMean**

**\$fBodyGyroscopeMagnitudeStandardDeviation**

**\$fBodyGyroscopeJerkMagnitudeMean**

**\$fBodyGyroscopeJerkMagnitudeStandardDeviation**
