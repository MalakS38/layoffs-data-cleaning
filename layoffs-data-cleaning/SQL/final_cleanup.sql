-- Data Cleaning: sql project 
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022


-- Inspect and handle NULL values or missing values


-- Check rows with missing total_laid_off or percentage_laid_off
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;


-- removing rows where both total_laid_off and percentage_laid_off are missing
-- No layoff data here, so these rows are not useful
DELETE FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- preview data 
SELECT * 
FROM world_layoffs.layoffs_staging2;

-- Final cleanup -  dropping temp columns such as row_num that was created as a helper column

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


-- Preview final cleaned table
SELECT * 
FROM world_layoffs.layoffs_staging2;
