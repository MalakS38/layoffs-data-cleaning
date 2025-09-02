-- Data Cleaning: sql project 
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022


-- Preview all data from the raw layoffs table in order to understand structure and content before cleaning

SELECT * 
FROM world_layoffs.layoffs;


-- creating a staging table and copying raw data into staging table 
-- in order to safely clean and transform data without altering the original raw dataset

CREATE TABLE world_layoffs.layoffs_staging 
LIKE world_layoffs.layoffs;

-- Inserting all rows from raw table into staging table
INSERT INTO world_layoffs.layoffs_staging
SELECT * FROM world_layoffs.layoffs;

-- Preview data in new staging table 
SELECT * 
FROM world_layoffs.layoffs_staging;
