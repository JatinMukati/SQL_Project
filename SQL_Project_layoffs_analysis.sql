
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null vzalues or blank values
-- 4. Remove Columns or rows 

-- https://www.kaggle.com/datasets/swaptr/layoffs-2022

-- First, we create a staging table. This will be used for data cleaning and preparation. 
-- The original data remains unchanged, allowing us to have a backup in case anything goes wrong.

CREATE TABLE layoffs_staging 
LIKE layoffs;

INSERT INTO layoffs_staging 
SELECT * FROM world_layoffs.layoffs;

-- Identifying duplicates and cleaning them
WITH duplicate_cte AS (
    SELECT *, 
    ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, funds_raised_millions, country) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Another way to identify duplicates:
SELECT *
FROM (
    SELECT company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions,
    ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) AS row_num
    FROM layoffs_staging
) duplicates
WHERE row_num > 1;

-- Checking specific company records
SELECT *
FROM layoffs_staging
WHERE company = 'Zymergen';

-------------------------------------------------------------

/* 
Since there is no unique column, we need to create a new table to manage and remove duplicates.
This new table will help clean the data.
*/

CREATE TABLE layoffs_staging2 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off NUMERIC,
    percentage_laid_off TEXT,
    date DATE,
    stage TEXT,
    country TEXT,
    funds_raised_millions NUMERIC,
    row_num INT
);

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2;

-- Remove duplicate rows
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- Standardizing data (e.g., removing trailing spaces)
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Check for specific industry patterns
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- Unifying inconsistent industry names
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Check for distinct country names and standardize them
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- Remove trailing dissimilarities (like "United States.")
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Date formatting: Changing the date format by adding a new column and removing the old one
SELECT TO_CHAR(date, 'DD/MM/YYYY')
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2 
ADD COLUMN formatted_date TEXT;

UPDATE layoffs_staging2
SET formatted_date = TO_CHAR(date, 'DD/MM/YYYY');

SELECT formatted_date, TO_CHAR(date, 'DD/MM/YYYY')
FROM layoffs_staging2;

-- Removing the old 'date' column and renaming the new one
ALTER TABLE layoffs_staging2
DROP COLUMN date;

ALTER TABLE layoffs_staging2
RENAME COLUMN formatted_date TO date_n;

-- Adding a new date column with the correct format
ALTER TABLE layoffs_staging2 
ADD COLUMN new_date DATE;

UPDATE layoffs_staging2 
SET new_date = TO_DATE(date_n, 'DD/MM/YYYY');

ALTER TABLE layoffs_staging2 
DROP COLUMN date_n;

ALTER TABLE layoffs_staging2 
RENAME COLUMN new_date TO date_n;

-------------------------------------------------------------

-- Checking for records with null values in key columns
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Finding and updating null values based on similar company names
SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- Update missing industry data by matching companies
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

-- Manually updating missing or incorrect industry names for specific companies
UPDATE layoffs_staging2
SET industry = 'Travel'
WHERE company = 'Airbnb';

UPDATE layoffs_staging2
SET industry = 'Transportation'
WHERE company = 'Carvana';

UPDATE layoffs_staging2
SET industry = 'Consumer'
WHERE company = 'Juul';

/*
You could try this query for missing industry values as well:
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';
*/

-- Final check of the updated data
SELECT *
FROM layoffs_staging2;

-- Deleting rows with null values in key columns and removing the row_num column
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Final dataset check
SELECT *
FROM layoffs_staging2;


------------------------------------------------------------

-- Exploratory Data Analysis (EDA)

-- Here we are just going to explore the data and find trends, patterns, or anything interesting like outliers.
-- Normally when you start the EDA process, you have some idea of what you're looking for.
-- With this info, we are just going to look around and see what we find!

SELECT * 
FROM world_layoffs.layoffs_staging2;

-- Max Layoffs
SELECT MAX(total_laid_off)
FROM world_layoffs.layoffs_staging2;

-- Looking at Percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;

-- Which companies had 100% of their company laid off
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1;

-- If we order by funds_raised_millions, we can see how big some of these companies were
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Companies with the biggest single layoff
SELECT company, total_laid_off
FROM world_layoffs.layoffs_staging
ORDER BY total_laid_off DESC
LIMIT 5;

-- Companies with the most total layoffs
SELECT company, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC
LIMIT 10;

-- Layoffs by location
SELECT location, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY SUM(total_laid_off) DESC
LIMIT 10;

-- Layoffs by country
SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY SUM(total_laid_off) DESC;

-- Layoffs by year
SELECT YEAR(date), SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY YEAR(date)
ORDER BY YEAR(date) ASC;

-- Layoffs by industry
SELECT industry, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC;

-- Layoffs by stage
SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY SUM(total_laid_off) DESC;

-- Companies with the most layoffs per year
WITH Company_Year AS (
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM world_layoffs.layoffs_staging2
  GROUP BY company, YEAR(date)
),
Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

-- Rolling total of layoffs per month
SELECT SUBSTRING(date, 1, 7) AS dates, SUM(total_laid_off) AS total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;

-- Use it in a CTE so we can query off of it
WITH DATE_CTE AS (
  SELECT SUBSTRING(date, 1, 7) AS dates, SUM(total_laid_off) AS total_laid_off
  FROM world_layoffs.layoffs_staging2
  GROUP BY dates
  ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) AS rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;

