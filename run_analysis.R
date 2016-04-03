# Need to download the files and unzip the data sets
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dst_file <- "./Phone_Active.zip"
download.file(fileURL,dst_file)

unzip(zipfile = "./Phone_Active.zip",exdir = "./phone_data")

f_path <- file.path("./phone_data","UCI HAR Dataset")

# Need to then read the data in and assign the files to data frames

test_activity <- read.table(file.path(f_path,"test","Y_test.txt"),header = FALSE)
train_activity <- read.table(file.path(f_path,"train","Y_train.txt"),header = FALSE)
test_subject <- read.table(file.path(f_path,"test","subject_test.txt"),header = FALSE)
train_subject <- read.table(file.path(f_path,"train","subject_train.txt"),header = FALSE)
test_features <- read.table(file.path(f_path,"test","X_test.txt"),header = FALSE)
train_features <- read.table(file.path(f_path,"train","X_train.txt"),header = FALSE)

# Once the files are read in, they need to be merged, so that only one data set is used

subjectData <- rbind(train_subject,test_subject)
activityData <- rbind(train_activity,test_activity)
featureData <- rbind(train_features,test_features)

# Create names for the variables so you know which is which

names(subjectData) <- c("Subject")
names(activityData) <- c("Activity")
FeaturesNames <- read.table(file.path(f_path,"features.txt"),header = FALSE)
names(featureData) <- FeaturesNames$V2

# Now that all variables are created, the file can be merged

first_merge <- cbind(subjectData,activityData)
Phone_Data <- cbind(featureData,first_merge)

# We now want to get only the mean and standard deviations for each measurement
# and then we want to subset the data frame by the feature names

mn_stdv_sub <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
select_few <- c(as.character(mn_stdv_sub),"Subject","Activity")
Phone_Data <- subset(Phone_Data, select = select_few)

# Now that we have it subsetted, want to use the descriptive variable names

activity_names <- read.table(file.path(f_path,"activity_labels.txt"),header = FALSE)

names(Phone_Data) <- gsub("^t","time",names(Phone_Data))
names(Phone_Data) <- gsub("^f","frequency",names(Phone_Data))
names(Phone_Data) <- gsub("Acc","Accelerometer",names(Phone_Data))
names(Phone_Data) <- gsub("Gyro","Gyroscope",names(Phone_Data))
names(Phone_Data) <- gsub("Mag","Magnitude",names(Phone_Data))
names(Phone_Data) <- gsub("BodyBody","Body",names(Phone_Data))

# Next we want to output one data set that is clean and correct

library(plyr)
Clean_Phone_Data <- aggregate(. ~Subject + Activity, Phone_Data, mean)
Clean_Phone_Data <- Clean_Phone_Data[order(Clean_Phone_Data$Subject,Clean_Phone_Data$Activity), ]
write.table(Clean_Phone_Data,file = "./clean_samsung_data.txt", row.names = FALSE)

