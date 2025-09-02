-- remove_duplicates.sql
-- Dataset: https://www.kaggle.com/datasets/swaptr/layoffs-2022
-- Purpose: Identify and remove duplicate rows from the layoffs staging table.

-- Preview data in the staging table
SELECT *
FROM world_layoffs.layoffs_staging;

-- Preview duplicates using ROW_NUMBER(), which assigns a unique number to each row 
-- within a group of identical values
SELECT *
FROM (
    SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
           ) AS row_num
    FROM world_layoffs.layoffs_staging
) duplicates
WHERE row_num > 1; -- Any row with row_num > 1 is a duplicate

-- filtering a specific company to confirm duplicates
SELECT *
FROM world_layoffs.layoffs_staging
WHERE company = 'zoom';

-- New staging table with a row_num column for duplicates
DROP TABLE IF EXISTS world_layoffs.layoffs_staging2;

CREATE TABLE world_layoffs.layoffs_staging2 (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT DEFAULT NULL,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert all rows into the new table and assign row numbers for duplicates
INSERT INTO world_layoffs.layoffs_staging2
SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions,
       ROW_NUMBER() OVER (
           PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
       ) AS row_num
FROM world_layoffs.layoffs_staging;

-- Preview rows flagged as duplicates where row_num > 1
SELECT * 
FROM world_layoffs.layoffs_staging2
WHERE row_num > 1;

-- Delete duplicate rows
DELETE  
FROM world_layoffs.layoffs_staging2
WHERE row_num > 1;
