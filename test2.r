# Load required libraries
library(caret)
library(randomForest)
library(ggplot2)
library(readxl)
library(dplyr)

# Load the dataset
file_path <- "C:/Users/Kavishka Herath/Desktop/R/.vscode/Cleaned_Transformed_Sales_Data.xlsx"
data <- read_excel(file_path)

# Convert categorical variables to factors
data <- data %>%
  mutate(
    Region = as.factor(Region),
    `Product Category` = as.factor(`Product Category`),
    `Payment Method` = as.factor(`Payment Method`)
  )

# Check for missing values
summary(data)

# Impute missing values using na.roughfix
data_clean <- na.roughfix(data)

# Ensure 'Delivery Time' column exists
if (!"Delivery Time" %in% colnames(data_clean)) {
  stop("The 'Delivery Time' column is missing from the dataset. Please ensure it is present or calculated before proceeding.")
}

# Split the dataset into training and testing sets
set.seed(123)
trainIndex <- createDataPartition(data_clean$`Delivery Time`, p = 0.8, list = FALSE)
trainData <- data_clean[trainIndex, ]
testData <- data_clean[-trainIndex, ]

# Build a Random Forest Model
model <- randomForest(
  `Delivery Time` ~ Region + `Product Category` + `Payment Method` + Quantity + `Order Year` + `Order Month`,
  data = trainData,
  ntree = 100,
  importance = TRUE
)

# Evaluate the Model
predictions <- predict(model, testData)
model_rmse <- sqrt(mean((testData$`Delivery Time` - predictions)^2))
model_r2 <- cor(testData$`Delivery Time`, predictions)^2

cat("Model RMSE:", model_rmse, "\n")
cat("Model R²:", model_r2, "\n")

# Plot variable importance
varImpPlot(model)


# Step 3: Feature Engineering
# Merge product popularity back into the main dataset
data_cleaned <- data_cleaned %>%
  left_join(product_popularity, by = "Product ID")