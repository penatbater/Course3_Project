## checks and installs the dplyr package if not yet installed

if("dplyr" %in%  rownames(installed.packages()) == FALSE){
    install.packages("dplyr")
}

library(dplyr)

## puts all elements into data frames
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
Ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
Ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
Xtrain <-read.table("./UCI HAR Dataset/train/X_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Step 1: combines all dataframes into one
rawdata <- bind_rows(bind_cols(subtest, Ytest, Xtest), bind_cols(subtrain,Ytrain,Xtrain))

## Step 2: selects only columns whose names in the feature.txt containts -mean()- or -std()-
meanstd <- grep("[[:punct:]]mean()[[:punct:]]|[[:punct:]]std()[[:punct:]]", features$V2)
z <- sapply(meanstd, function(x){x+2}) ## added +2 to each value because the 
                                       ## first two are the subject id and activity label
newdata <- select(rawdata, 1, 2, z)    ## selects the first 2 and other relevant columns with mean/std

## Step 3: Replaces all values in the second column (which is the activity label column) 
## with the actual activity words
newdata[,2] <- sapply(newdata[,2], function(x) activity[x,2])

## matches the descriptive name of the variable based on features.txt
namelist <- sapply(meanstd, function(x) features[x,2])

## simplifies some terms
namelist <- gsub("^t","Time", namelist)
namelist <- gsub("^f","Freq", namelist)
namelist <- gsub("[[:punct:]]mean\\(\\)","Mean",namelist)
namelist <- gsub("[[:punct:]]std\\(\\)","Std",namelist)

## Step4: changes the names to more descriptive variable names
names(newdata) <- c("SubjectID","ActivityLabel",namelist)


## Step 5: Summarizes into tidy data with average of each variable for each activity and each subject
tidydata <- group_by(newdata, SubjectID, ActivityLabel) %>% summarize_all(funs(mean))

print(tidydata)