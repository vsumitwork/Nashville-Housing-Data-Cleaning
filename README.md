# Data Cleaning Portfolio Project

This repository contains my **Data Cleaning Portfolio Project**, completed using SQL in SQL Server Management Studio (SSMS). The project involves cleaning and transforming a Nashville housing dataset to prepare it for analysis. The project focused on resolving common data quality issues such as inconsistencies, missing values, and duplicates, making the dataset analysis-ready.

---

## Key Features and Steps

### 1. **Standardizing Date Formats**
- Converted `SaleDate` column values to a consistent `YYYY-MM-DD` format for accurate filtering and sorting.

### 2. **Handling Missing Data**
- Addressed null values in the `PropertyAddress` column by filling them based on corresponding `ParcelID` values.

### 3. **Breaking Down Addresses**
- Split composite fields like `PropertyAddress` and `OwnerAddress` into individual columns:
  - Street Address
  - City
  - State
- Used SQL string functions such as `SUBSTRING` and `PARSENAME` for this process.

### 4. **Standardizing Field Values**
- Updated the `SoldAsVacant` field:
  - Replaced "Y" with "Yes" and "N" with "No" for improved clarity.

### 5. **Identifying and Removing Duplicates**
- Used a `ROW_NUMBER` CTE to identify duplicate records based on key attributes such as `ParcelID`, `SaleDate`, and `SalePrice`.
- Removed duplicate entries to ensure data consistency.

### 6. **Dropping Unnecessary Columns**
- Removed fields like `OwnerAddress`, `PropertyAddress`, and `TaxDistrict` to streamline the dataset.

---

## Project Files

The repository includes the following files:

1. **`Nashville Housing Data.xlsx`**
   - The original dataset containing raw housing data.
2. **`Data Cleaning Portfolio Project Queries.sql`**
   - The SQL queries used for cleaning and transforming the dataset.
3. **`README.md`**
   - This file, providing an overview of the project.

---

## Getting Started

To explore and replicate the project, follow these steps:

1. Clone the repository to your local system:
   ```bash
   git clone https://github.com/vsumitwork/Nashville-Housing-Data-Cleaning.git
   ```
2. Open the `Nashville Housing Data.xlsx` file to review the raw dataset.
3. Import the dataset into your SQL Server database:
   - Create a table in SQL Server and import the dataset using SSMS.
4. Execute the SQL queries in the `Data Cleaning Portfolio Project Queries.sql` file to clean and transform the data.
5. Analyze the cleaned data as needed for further insights or visualization.

---

## Tools and Technologies

- **SQL**: Primary tool for data cleaning and transformation.
- **SSMS (SQL Server Management Studio)**: Used for executing SQL queries.
- **Excel**: To view and preprocess raw data.

---
## Dataset Overview
The dataset consists of housing-related information, including:

- Parcel and property details
- Sale transaction records
- Ownership information
This project cleaned and structured the dataset to ensure accurate and meaningful analysis.

---

## Insights and Applications

After cleaning:
- The dataset is prepared for exploratory data analysis (EDA) and visualization.
- Trends in property sales, ownership, and pricing can now be analyzed more effectively.
- The project demonstrates best practices in data cleaning and handling real-world data issues.

---

## Contributing

Contributions are welcome! If you have suggestions or improvements, please fork the repository and submit a pull request. Alternatively, you can raise an issue for discussion.


