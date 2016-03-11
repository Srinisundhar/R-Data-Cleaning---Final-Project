#Program run_analysis - Data Cleaning - Final Project
#----------------------------------------------------------------------
# Read and merge the input data (features,activity, testing, training) 
# from the files (Step 1) 
#----------------------------------------------------------------------
features <- read.table("C:/Users/Srini/Documents/features.txt")
activity<-read.table("C:/Users/Srini/Documents/activity_labels.txt")
x_test <- read.table("C:/Users/Srini/Documents/X_test.txt")
y_test <- read.table("C:/Users/Srini/Documents/y_test.txt")
subject_test <- read.table("C:/Users/Srini/Documents/subject_test.txt")
x_train <- read.table("C:/Users/Srini/Documents/X_train.txt")
y_train <- read.table("C:/Users/Srini/Documents/y_train.txt")
subject_train <- read.table("C:/Users/Srini/Documents/subject_train.txt")
merged_data <- rbind(x_test, x_train)
merged_y <- rbind(y_test, y_train)
merged_subject <- rbind(subject_test, subject_train)
colNames <- as.character(features$V2)
colNames <- make.names(colNames, unique=TRUE)
names(merged_data) <- colNames
merged_data <- cbind(merged_y, merged_data)
names(merged_subject) = c('subjects')
merged_data <- cbind(merged_subject, merged_data)

#-------------------------------------------
# Extract the measurements on the mean and
# standard deviation for each measurement (Step 2)
#--------------------------------------------
ms_data <- select(merged_data, subjects,V1, contains(".mean."), contains(".std."))
ms_data$subjects <- as.factor(ms_data$subjects)
ms_data$V1 <- as.factor(ms_data$V1)

#-----------------------------------
# Name the activites in the data set using 
# descriptive activity names (Step 3)
#-----------------------------------
ms_data$V1 <- mapvalues(ms_data$V1, from = c("1", "2", "3", "4", "5", "6"), 
                         to = c("Walking", "WalkingUpStairs", "WalkingDownStairs", "Sitting", "Standing", "Lying"))
#---------------------------------------------------------------------------
# Appropriately labels the data set with descriptive variable names (Step 4)
#---------------------------------------------------------------------------

names(ms_data) <- str_replace_all(names(ms_data), "[.][.]", "")
names(ms_data) <- str_replace_all(names(ms_data), "BodyBody", "Body")
names(ms_data) <- str_replace_all(names(ms_data), "tBody", "TBody")
names(ms_data) <- str_replace_all(names(ms_data), "fBody", "FFTBody")
names(ms_data) <- str_replace_all(names(ms_data), "tGravity", "TGravity")
names(ms_data) <- str_replace_all(names(ms_data), "fGravity", "FFTGravity")
names(ms_data) <- str_replace_all(names(ms_data), "Acc", "Acceleration")
names(ms_data) <- str_replace_all(names(ms_data), "Gyro", "AngularVelocity")
names(ms_data) <- str_replace_all(names(ms_data), "Mag", "Magnitude")
for(i in 3:68) {if (str_detect(names(ms_data)[i], "[.]std")) 
                {names(ms_data)[i] <- paste0("StandardDeviation", str_replace(names(ms_data)[i], "[.]std", ""))}}
for(i in 3:68) {if (str_detect(names(ms_data)[i], "[.]mean")) 
                {names(ms_data)[i] <- paste0("Mean", str_replace(names(ms_data)[i], "[.]mean", ""))}}
names(ms_data) <- str_replace_all(names(ms_data), "[.]X", "XAxis")
names(ms_data) <- str_replace_all(names(ms_data), "[.]Y", "YAxis")
names(ms_data) <- str_replace_all(names(ms_data), "[.]Z", "ZAxis")

#-------------------------------------------------------------
# Create the tidy data set with the average of each variable 
# for each activity and each subject.
#-------------------------------------------------------------
split_set <- split(select(ms_data, 3:68), list(ms_data$subjects, ms_data$V1))
mean_set <- lapply(split_set, function(x) apply(x, 2, mean, na.rm=TRUE))
tidy_set <- data.frame(t(sapply(mean_set,c)))
factors <- data.frame(t(sapply(strsplit(rownames(tidy_set), "[.]"),c)))
tidy_set <- cbind(factors, tidy_set)

#-------------------------------------------------
# Provide user friendly subject and activity names
#--------------------------------------------------
tidy_set <- dplyr::rename(tidy_set,Subject = X1, Activity = X2)
tidy_set$Subject <- as.factor(tidy_set$Subject)
tidy_set$Activity <- as.factor(tidy_set$Activity)
rownames(tidy_set) <- NULL
#-----------------------------------
# Write the tidy set to output file 
#-----------------------------------
write.table(tidy_set, "tidy_data_set.txt", row.names=FALSE)

