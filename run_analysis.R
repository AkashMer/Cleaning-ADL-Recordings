# R version when script was written
# R version 4.3.0 (2023-04-21 ucrt)
run_analysis <- function() {
    
    ## Libraries used in this R script
    if(system.file(package = "dplyr") == "") install.packages("dplyr")
    library(dplyr) # Version: ‘1.1.2’
    
    # Downloading the raw data and storing it in the raw data directory
    dir.create("./raw data") #Creating the directory
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    temp <- tempfile()
    download.file(fileURL, temp, method = "curl")
    unzip(temp, exdir = "./raw data") #Extracts all the data
    unlink(temp) #Deletes the zip file
    
    # Reading in the training and test sets
    train <- read.table("./raw data/UCI HAR Dataset/train/X_train.txt")
    test <- read.table("./raw data/UCI HAR Dataset/test/X_test.txt")
    dim(train)  #Train dataset has 7352 rows and 561 columns
    dim(test)   #Test dataset has 2947 rows and 561 columns
    
    # Reading in the feature list corresponding to the columns of both data sets
    features <- read.table("./raw data/UCI HAR Dataset/features.txt")[,2]
    
    # Reading in the activity labels
    tmp <- read.table("./raw data/UCI HAR Dataset/activity_labels.txt")
    activitylabels <- sub("_","",tolower(tmp[,2]))
    
    # Reading in the information on subject and type of activity for our datasets
    tmp <- read.table("./raw data/UCI HAR Dataset/train/y_train.txt")
    activitytrain <- tmp[,1] #Denotes the activity being performed by the subject
    tmp <- read.table("./raw data/UCI HAR Dataset/test/y_test.txt")
    activitytest <- tmp[,1] #Denotes the activity being performed by the subject
    tmp <- read.table("./raw data/UCI HAR Dataset/train/subject_train.txt")
    subjecttrain <- tmp[,1] #Denotes the subject corresponding to each row
    tmp <- read.table("./raw data/UCI HAR Dataset/test/subject_test.txt")
    subjecttest <- tmp[,1] #Denotes the subject corresponding to each row
    
    # Adding the feature names as column names of the 2 data sets
    names(train) <- features
    names(test) <- features
    
    # Adding the subject and activity information to both datasets
    train <- cbind(subject = subjecttrain, activity = activitytrain, train)
    test <- cbind(subject = subjecttest, activity = activitytest, test)
    
    ## Extracting only the mean and standard deviation of each measurement
    train <- train %>%
        select(activity, subject, grep("mean\\(\\)|std\\(\\)", 
                                       names(train), value = TRUE))
    test <- test %>%
        select(activity, subject, grep("mean\\(\\)|std\\(\\)", 
                                       names(test), value = TRUE))
    # where the expression mean\\(\\)|std\\(\\) corresponds
    # specifically to mean() and std()
    
    ## Merging the 2 datasets
    dat <- merge(train,test,
                 by.x = names(train),
                 by.y = names(test), all = TRUE)
    # This merging also orders the data by the common columns

    # Editing the features to be more descriptive
    variables <- gsub("-|\\(|\\)", "", names(dat))
    variables <- sub("Acc", "Acceleration", variables)
    variables <- sub("Gyro", "Gyroscope", variables)
    variables <- sub("Mag", "Magnitude", variables)
    variables <- sub("mean", "Mean", variables)
    variables <- sub("std", "StandardDeviation", variables)
    variables <- sub("BodyBody", "Body", variables)
    
    ## Performing the following transformations on the merged data
    # 1.Changing the activity column as a vector whose labels represent
    #   descriptive names of activities being measured
    # 2.Changing the subject column to a vector
    # 3.Renaming the variables to be more descriptive
    dat <- dat %>%
        mutate(activity = factor(activity, labels = activitylabels)) %>%
        mutate(subject = factor(subject))
    names(dat) <- variables
    
    ## Tidy data set with the average of each variable
    ## for each activty and each subject
    tidy_dat <- dat %>%
        group_by(activity,subject) %>%
        summarize(across(1:66, mean))
    
    return(tidy_dat)
}