# R-Data-Cleaning---Final-Project
This repository contains the (a) R code (b) Tidy Data set (c) Code Book for the  R - Data Cleaning course - Final project

Overview

codebook.md describes the specific details of variables, values, and units in the tidy data set.

The tidy_data_set.txt file in this directory is a tidy subset of the data provided in the Human Activity 

Recognition Using Smartphones Data Set. T

tidy_data_set.txt includes the combined test and training data sets from the following files:

subject_test.txt
activity_labels.txt
X_test.txt
y_test.txt
subject_train.txt
X_train.txt
y_train.txt


codebook.md describes the tidy data set.

Description of run_analysis.R

run_analysis.R takes source data from the  Dataset directory, imports it into R, and converts it into a tidy 

data subset.

The script performs the following operations to import, clean, and transform the data set.

1. Read the files from the test and training data and merge the training and test sets to create one data set.
	a. Combine the values from the subject_test and subject_train files to create a single Subject column that 
 identifies the study participant.
	b. Combine the values from the y_test and y_train data to create a single Activity column that indicates 	
that activity class (for instance, walking or sitting).
	c. Combine the values from the X_test and X_train files to create additional variable columns, one column 	
for each measurement and calculation included in the data set 

2.Extract only the measurements on the mean and standard deviation for each measurement.

3.Use descriptive activity names to name the activities in the data set.

4. Appropriately label the data set with descriptive variable names.

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for 
each activity and each subject.
