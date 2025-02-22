# Load necessary libraries
library(dplyr)

# Read data
features_link   <- "UCI HAR Dataset/features.txt"
activities_link <- "UCI HAR Dataset/activity_labels.txt"
x_test_link     <- "UCI HAR Dataset/test/X_test.txt"
y_test_link     <- "UCI HAR Dataset/test/y_test.txt"
x_train_link    <- "UCI HAR Dataset/train/X_train.txt"
y_train_link    <- "UCI HAR Dataset/train/y_train.txt"

features    <- read.table(features_link,    col.names = c("n", "functions"))
activities  <- read.table(activities_link,  col.names = c("code", "activity"))
x_test      <- read.table(x_test_link,      col.names = features$functions)
y_test      <- read.table(y_test_link,      col.names = "code")
x_train     <- read.table(x_train_link,     col.names = features$functions)
y_train     <- read.table(y_train_link,     col.names = "code")

# Merge data
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
merged_data <- cbind(y, x)

# Extract only mead and standard deviation
merged_data <- merged_data %>% select(code, contains("mean"), contains("std"))

# Replace code with descriptive activity names
merged_data <- merge(merged_data, activities, by = "code", all.x = TRUE)
merged_data <- select(merged_data, -code)

# Clean up variable names to be more descriptive
names(merged_data) <- gsub("^t",       "Time",              names(merged_data))
names(merged_data) <- gsub("Freq",     "Frequency",         names(merged_data))
names(merged_data) <- gsub("^f",       "Frequency",         names(merged_data))
names(merged_data) <- gsub("Acc",      "Accelerometer",     names(merged_data))
names(merged_data) <- gsub("Gyro",     "Gyroscope",         names(merged_data))
names(merged_data) <- gsub("Mag",      "Magnitude",         names(merged_data))
names(merged_data) <- gsub("BodyBody", "Body",              names(merged_data))
names(merged_data) <- gsub("tBody",    "TimeBody",          names(merged_data))
names(merged_data) <- gsub("mean",     "Mean",              names(merged_data))
names(merged_data) <- gsub("std",      "StandardDeviation", names(merged_data))

# Create a tidy data set with only the average of each variable by activity
tidy_data <- merged_data %>% group_by(activity) %>% summarise_all(funs(mean))

write.table(tidy_data, "tidy_data.txt", row.name = FALSE)