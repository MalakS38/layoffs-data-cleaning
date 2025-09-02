# Layoffs Data Cleaning Project


This project demonstrates SQL data cleaning techniques on a dataset of company layoffs (2022) including removing duplicates, standardizing text, handling null values, and preparing the data for analysis. Inspired by Alex The Analyst 

---

## Dataset

- **Source:** Kaggle – [Layoffs 2022 Dataset](https://www.kaggle.com/datasets/swaptr/layoffs-2022)  
- **Columns:**  
  - `company` – Name of the company  
  - `location` – Location of the company  
  - `industry` – Industry sector  
  - `total_laid_off` – Number of layoffs  
  - `percentage_laid_off` – Percentage of workforce laid off  
  - `date` – Date of layoff event  
  - `stage` – Funding stage of the company  
  - `country` – Country  
  - `funds_raised_millions` – Funding amount in millions  

---

## Project Workflow

### **Step 1: Creating a Staging Table**
- Copying the raw data into a staging table to preserve the original dataset.
- **SQL Script:** `create_staging_table.sql`

### **Step 2: Remove Duplicates**
- Identify duplicates using `ROW_NUMBER()` with `PARTITION BY` on all key columns.  
- Delete duplicate rows and keep one copy.
- **SQL Script:** `remove_duplicates.sql`

### **Step 3: Standardize Data**
- Trim extra spaces from text columns.  
- Standardize industry names (e.g., unify “Crypto Currency” and “CryptoCurrency” → “Crypto”).  
- Removing trailing periods.  
- Convert `date` column from text to proper `DATE` type.  
- **SQL Script:** `standardize_data.sql`

### **Step 4: Final Cleanup**
- Identify NULL or empty fields.  
- Populate missing industry values from other rows for the same company.  
- Deleting rows without usable layoffs data.  
- Droping temporary columns (e.g., `row_num`).   
- **SQL Script:** `final_cleanup.sql`

---

## **Before & After**
**Before Cleaning:**  
- Duplicate rows  
- Inconsistent industry titles and Mixed country formats 
- Dates in text format  

**After Cleaning:**  
- Only unique rows remain
- Standardized text and consistent formatting  
- Proper DATE column  
- Nulls handled for easier analysis  





