-- standardize_data.sql
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022

-- Standardize text columns & clean data


-- Trim spaces: removing any extra spaces at beginning/end of company titles

UPDATE world_layoffs.layoffs_staging2
SET company = TRIM(company);

-- Set empty  ('') industry fields to NULL for consistency (& easier to work with)
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Fill missing industry using data from the same company that are available

UPDATE world_layoffs.layoffs_staging2 t1
JOIN world_layoffs.layoffs_staging2 t2
  ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Standardize Crypto industry variations, ensuring values are consistent

UPDATE world_layoffs.layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');


-- in country column, some are added as "United States" and some as "United States."
SELECT DISTINCT country
FROM world_layoffs.layoffs_staging2
ORDER BY country;

-- Standardize country names by removing trailing period for consistency
UPDATE world_layoffs.layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);



SELECT *
FROM world_layoffs.layoffs_staging2;  -- date column needs to be updated 


-- converting date column from text format to proper DATE type
UPDATE world_layoffs.layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- changing date column data type to DATE in the table
ALTER TABLE world_layoffs.layoffs_staging2
MODIFY COLUMN `date` DATE;
