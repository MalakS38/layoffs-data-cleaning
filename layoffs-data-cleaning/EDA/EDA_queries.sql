-- EDA_queries.sql
-- Project: Layoffs Data Analysis - Exploratory Data Analysis (EDA)
-- Description: This SQL script performs exploratory data analysis (EDA) on the layoffs dataset to uncover trends, patterns, and insights.
--     Inspired by: Alex The Analyst 



-- 1. Basic ExplorationF

-- View cleaned dataset
SELECT * 
FROM layoffs_staging2;

-- Basic stats
SELECT MAX(total_laid_off), MIN(total_laid_off) 
FROM layoffs_staging2;

-- Min & Max Percentage of layoffs 
SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;

-- Companies with full layoffs (100%)
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC; -- sorted by highest funding to see the largest ones


-- 2. Aggregations & Rankings

-- Companies with the largest single day layoff 
SELECT company, total_laid_off
FROM layoffs_staging2
ORDER BY total_laid_off DESC; 

-- highest total layoffs (all-time)
SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC;

-- Total layoffs by location
SELECT location, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY location
ORDER BY total_laid_off DESC;

-- Total layoffs by country
SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;

-- Total layoffs by year
SELECT YEAR(date) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY year ASC;


-- 3. Time-Based Analysis


-- Rolling total layoffs per month
WITH DATE_CTE AS (
    SELECT SUBSTRING(date,1,7) AS month, SUM(total_laid_off) AS total_laid_off
    FROM .layoffs_staging2
    GROUP BY month
    ORDER BY month ASC
)

SELECT month, SUM(total_laid_off) OVER (ORDER BY month ASC) AS rolling_total_layoffs
FROM DATE_CTE
ORDER BY month ASC;






-- 4. Additional Insights 

-- Top 3 companies with most layoffs per year
WITH Company_Year AS (
    SELECT company, YEAR(date) AS year, SUM(total_laid_off) AS total_layoffs
    FROM layoffs_staging2
    GROUP BY company, YEAR(date)
),
Ranked AS (
    SELECT company, year, total_layoffs, 
           DENSE_RANK() OVER (PARTITION BY year ORDER BY total_layoffs DESC) AS rank_num
    FROM Company_Year
)
SELECT company, year, total_layoffs, rank_num
FROM Ranked
WHERE rank_num <= 3
ORDER BY year ASC, total_layoffs DESC;




-- Average layoffs per industry
SELECT industry, AVG(total_laid_off) AS avg_layoffs
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY avg_layoffs DESC;


