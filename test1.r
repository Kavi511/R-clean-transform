# Load required libraries
library(readxl)
library(dplyr)
library(lubridate)
library(writexl)

# Step 1: Load the dataset
data <- read_excel("Sales_Records_2015_2020_Corrected.xlsx")
print("Initial Data:")
print(head(data))  # Check the first few rows of the loaded data

# Step 2: Data Cleaning - Remove duplicates
data_cleaned <- data %>%
  distinct()
print("After Removing Duplicates:")
print(head(data_cleaned))  # Check after removing duplicates

# Step 3: Handle missing values
data_cleaned <- data_cleaned %>%
  filter(!is.na(`Order Date`) & !is.na(Region) & !is.na(`Total Price`))
print("After Handling Missing Values:")
print(head(data_cleaned))  # Check after filtering missing values
print(paste("Number of Rows After Filtering:", nrow(data_cleaned)))

# Step 4: Data Transformation - Convert 'Order Date' and extract date components
data_cleaned <- data_cleaned %>%
  mutate(
    `Order Date` = as.Date(`Order Date`, format = "%Y-%m-%d"),
    `Order Year` = year(`Order Date`),
    `Order Month` = month(`Order Date`),
    `Order Day` = day(`Order Date`)
  )
print("After Date Transformation:")
print(head(data_cleaned))  # Check the transformed data

# Optional: Save the cleaned and transformed data to a new Excel file
write_xlsx(data_cleaned, "Cleaned_Transformed_Sales_Data.xlsx")
print("Data cleaning and transformation completed successfully!")
