# Getting and Cleaning Data - Course Project

This repository contains the R script `run_analysis.R` which performs data cleaning and analysis on the Human Activity Recognition Using Smartphones Dataset.

## Analysis Steps

1. **Load necessary libraries**: The script uses the `dplyr` library for data manipulation.

2. **Read data**: The script reads the following data files:
   - `features.txt`: Contains the feature names.
   - `activity_labels.txt`: Contains the activity labels.
   - `X_test.txt` and `X_train.txt`: Contains the test and train data sets.
   - `y_test.txt` and `y_train.txt`: Contains the activity codes for the test and train data sets.
   - `subject_test.txt` and `subject_train.txt`: Contains the subject identifiers for the test and train data sets.

3. **Merge data**: The script merges the test and train data sets to create one data set.

4. **Extract mean and standard deviation**: The script extracts only the measurements on the mean and standard deviation for each measurement.

5. **Replace activity codes with descriptive names**: The script replaces the activity codes with descriptive activity names.

6. **Clean up variable names**: The script cleans up the variable names to make them more descriptive.

7. **Create a tidy data set**: The script creates a tidy data set with the average of each variable for each activity and each subject.

8. **Write the tidy data set to a file**: The script writes the tidy data set to `final_data.txt`.

## Files

- `run_analysis.R`: The R script that performs the analysis.
- `final_data.txt`: The output tidy data set.
