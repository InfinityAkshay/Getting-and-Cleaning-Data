# Load necessary libraries
library(dplyr)

# Read data
features_link       <- "UCI HAR Dataset/features.txt"
activities_link     <- "UCI HAR Dataset/activity_labels.txt"
x_test_link         <- "UCI HAR Dataset/test/X_test.txt"
y_test_link         <- "UCI HAR Dataset/test/y_test.txt"
subject_test_link   <- "UCI HAR Dataset/test/subject_test.txt"
x_train_link        <- "UCI HAR Dataset/train/X_train.txt"
y_train_link        <- "UCI HAR Dataset/train/y_train.txt"
subject_train_link  <- "UCI HAR Dataset/train/subject_train.txt"

features      <- read.table(features_link,   col.names = c("n", "functions"))
activities    <- read.table(activities_link, col.names = c("code", "activity"))

x_test        <- read.table(x_test_link,  col.names = features$functions)
y_test        <- read.table(y_test_link,  col.names = "code")
x_train       <- read.table(x_train_link, col.names = features$functions)
y_train       <- read.table(y_train_link, col.names = "code")

subject_test  <- read.table(subject_test_link,  col.names = "subject")
subject_train <- read.table(subject_train_link, col.names = "subject")

# Merge data
x       <- rbind(x_train, x_test)
y       <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

data <- cbind(y, x, subject)

# Extract only mead and standard deviation
tidy_data <- data %>% select(code, subject, contains("mean"), contains("std"))

# Replace code with descriptive activity names
tidy_data <- merge(tidy_data, activities, by = "code", all.x = TRUE)
tidy_data <- select(tidy_data, -code)

# Clean up variable names to be more descriptive
names(tidy_data) <- gsub("^t",       "Time",              names(tidy_data))
names(tidy_data) <- gsub("Freq",     "Frequency",         names(tidy_data))
names(tidy_data) <- gsub("^f",       "Frequency",         names(tidy_data))
names(tidy_data) <- gsub("Acc",      "Accelerometer",     names(tidy_data))
names(tidy_data) <- gsub("Gyro",     "Gyroscope",         names(tidy_data))
names(tidy_data) <- gsub("Mag",      "Magnitude",         names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body",              names(tidy_data))
names(tidy_data) <- gsub("tBody",    "TimeBody",          names(tidy_data))
names(tidy_data) <- gsub("mean",     "Mean",              names(tidy_data))
names(tidy_data) <- gsub("std",      "StandardDeviation", names(tidy_data))

final_data <- tidy_data %>% group_by(activity, subject) %>% summarise_all(mean)

write.table(final_data, "final_data.txt", row.name = FALSE)