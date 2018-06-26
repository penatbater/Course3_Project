Getting and Cleaning Data Project
Week 4
====================================
Stephen Chan
www.github.com/penatbater
====================================

run_analysis.R runs a script that summarizes and tidies the data pertaining to the Human Activity Recognition Using Smartphones Dataset Version 1.0. The dataset is included in the folder 'Dataset'.

The script combines the training and test sets results into one data set, including the subjectID and the activity. 

It then extracts only the measurements on the mean and standard deviation for each measurement, i.e. all variables that end in mean() or std(). 

Activity names replace the value under the ActivityLabel column for easier readability, as well as replacing all other column names with more understandable descriptive names.

Lastly, the script creates a separate tidy data set with the averages of each variable per subject. 

For further data analysis, 'new data' is the final full dataframe, while 'tidy data' is the summarized dataframe.


IMPORTANT: For the script to run properly, the folder 'UCI HAR Dataset' must be on the same environment as the script.
