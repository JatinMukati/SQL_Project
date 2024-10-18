
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null vzalues or blank values
-- 4. Remove Columns or rows 

-- https://www.kaggle.com/datasets/swaptr/layoffs-2022

-- first thing we want to do is create a staging table. This is the one we will work in and clean the data. We want a table with the raw data in case something happens
CREATE TABLE layoffs_staging 
LIKE layoffs

INSERT layoffs_staging 
SELECT * FROM world_layoffs.layoffs



-- Identifying duplicates and Cleaning
with duplicate_cte as(
SELECT * ,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,'date',stage, funds_raised_millions,country) as row_num
FROM layoffs_staging
)

SELECT *
FROM duplicate_cte
where row_num > 1

-- Another way for the same
SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,'date', stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,'date', stage, country, funds_raised_millions
			) AS row_num
	FROM 
		layoffs_staging
) duplicates
WHERE 
	row_num > 1;

select *
from layoffs_staging
where company = 'Zymergen'

-------------------------------------------------------------
/* 

We have to make another table for deleting duplicates,
because the main thing is there is no unique column, 
So that's why we have to go through this.

*/
CREATE TABLE layoffs_staging2 (
    company text,
    location text,
    industry text,
    total_laid_off numeric,
    percentage_laid_off text,
    date date,
    stage text,
    country text,
    funds_raised_millions numeric,
    row_num int
    .
  )

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,'date', stage, country, funds_raised_millions
			) AS row_num
FROM layoffs_staging

SELECT *
FROM layoffs_staging2 

DELETE
FROM layoffs_staging2
WHERE  row_num > 1


-- Standardising data

UPDATE layoffs_staging2
SET company = TRIM(company)

SELECT *
FROM layoffs_staging2
WHERE industry like 'Crypto%'

-- Making data similar by changing multiple type same names  
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry like 'Crypto%'

SELECT DISTINCT country
FROM layoffs_staging2
order by 1

-- Removing trail disimilarity like( "United States." )
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country like 'United States%'


-- Changing date format by adding new column and deleting old 
-- because it's showing error due to date 
SELECT TO_CHAR(date, 'DD/MM/YYYY')
FROM layoffs_staging2

ALTER TABLE layoffs_staging2 
ADD COLUMN formatted_date text
UPDATE layoffs_staging2
SET formatted_date = TO_CHAR(date, 'DD/MM/YYYY') 

select formatted_date,TO_CHAR(date, 'DD/MM/YYYY')
from layoffs_staging2

ALTER TABLE layoffs_staging2
DROP COLUMN date

ALTER TABLE layoffs_staging2
RENAME COLUMN formatted_
date to date_n


--NEW Column added and renamed
ALTER TABLE layoffs_staging2 ADD COLUMN new_date DATE;
UPDATE layoffs_staging2 
SET new_date = TO_DATE(date_n, 'DD/MM/YYYY');
ALTER TABLE layoffs_staging2 DROP COLUMN date_n;
ALTER TABLE layoffs_staging2 
RENAME COLUMN new_date TO date_n;
-----------------------------------------------------------------

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL

-- Finding null data with similiar industry and company 
SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry ='')
AND t2.industry IS NOT NULL

--This Will update the data that is missing or say similar industry with comapany
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL 


-- Updated data separately by this because that query is not working for me
UPDATE layoffs_staging2
SET industry = 'Travel'
WHERE company = 'Airbnb'

UPDATE layoffs_staging2
SET industry = 'Transportation'
WHERE company = 'Carvana'

UPDATE layoffs_staging2
SET industry = 'Consumer'
WHERE company = 'Juul'

/*

May be above query will work also by this query but i forget so check if irt works 
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ''

*/
SELECT*
FROM layoffs_staging2

-- Deleting null rows and row_num column
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL

ALTER TABLE layoffs_staging2
DROP COLUMN row_num

SELECT *
FROM layoffs_staging2

------------------------------------------------------------

-- Exploratary Data Analysis


SELECT MAX(total_laid_off)
FROM layoffs_staging2

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = '1'

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off ='1'
ORDER BY funds_raised_millions DESC
