# Install necessary libraries
install.packages("readxl")
install.packages("dplyr")
install.packages("lubridate")
library(lubridate)
sales_data <- sales_data %>%
  mutate(`Order Date` = ymd(`Order Date`)) # Automatically detect and parse the date format


# Load libraries
library(readxl)
library(dplyr)

# Set file path to your dataset
file_path <- "C:/Users/Kavishka Herath/Desktop/R/Sales_Records_2015_2020_Corrected.xlsx"

# Load the dataset
sales_data <- read_excel(file_path)

# Check the structure of the dataset to confirm column names and data types
str(sales_data)

# Ensure 'Order Date' is properly formatted as a date
# Adjust the format to match the actual data in your file
sales_data <- sales_data %>%
  mutate(`Order Date` = as.Date(`Order Date`, format = "%Y-%m-%d")) # Update this format if necessary

# Add time dimensions: Year and Quarter
sales_data <- sales_data %>%
  mutate(
    Year = format(`Order Date`, "%Y"), # Extract year
    Quarter = paste0("Q", ((as.numeric(format(`Order Date`, "%m")) - 1) %/% 3 + 1)) # Correct quarter calculation
  )

# Summarize data for the data cube
data_cube <- sales_data %>%
  group_by(Year, Quarter, Region, `Product Category`) %>% # Group by relevant dimensions
  summarize(
    Total_Revenue = sum(`Total Price`, na.rm = TRUE), # Calculate total revenue
    Total_Quantity_Sold = sum(Quantity, na.rm = TRUE), # Calculate total quantity sold
    Average_Revenue_per_Order = mean(`Total Price`, na.rm = TRUE) # Calculate average revenue per order
  ) %>%
  ungroup()

# View the summarized data cube
print(data_cube)

# Save the summarized data cube to a CSV file
write.csv(data_cube, "C:/Users/Kavishka Herath/Desktop/R/Sales_Data_Cube.csv", row.names = FALSE)
