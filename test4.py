import pandas as pd
# Load the Excel file to check its contents
file_path = r"C:\Users\Kavishka Herath\Desktop\R\.vscode\Sales_Records_2015_2020_Corrected.xlsx"
excel_file = pd.ExcelFile(file_path)


# Display sheet names to understand the structure of the file
excel_file.sheet_names


# Load the data from the first sheet to examine its structure
data = pd.read_excel(file_path, sheet_name='Sheet1')

# Display the first few rows of the dataset to understand its content
data.head()
print(data.head())
