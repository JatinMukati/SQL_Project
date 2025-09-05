# SQL-Project

# Layoffs 2022 Analysis

This repository contains an analysis of the Layoffs 2022 dataset from Kaggle ([Link to Dataset](https://www.kaggle.com/datasets/swaptr/layoffs-2022)).  The analysis focuses on data cleaning, standardization, and exploratory data analysis (EDA) to uncover trends and insights within the layoff data.

## Data Cleaning and Preparation

The initial dataset required significant cleaning and standardization.  The following steps were performed:

* **Duplicate Removal:** Duplicates were identified and removed using window functions (`ROW_NUMBER()`) to ensure data accuracy.
* **Data Standardization:**
    * Trailing spaces were removed from company and country names.
    * Inconsistent industry names (e.g., "Crypto," "Cryptocurrency") were unified.
    * Country names were standardized (e.g., "United States." to "United States").
    * Date format was corrected and standardized.
* **Handling Null Values:**  Missing industry values were imputed by referencing other records with the same company name. Remaining records with null values in crucial columns (`total_laid_off`, `percentage_laid_off`) were removed.

## Exploratory Data Analysis (EDA)

The cleaned dataset was then explored to identify key trends and patterns in the layoff data.  The analysis included:

* **Maximum Layoffs:** Identifying the company with the highest single layoff event.
* **Percentage Laid Off:** Analyzing the distribution of percentage layoffs, including companies with 100% layoffs.
* **Layoff Aggregations:**  Calculating total layoffs by company, location, country, year, industry, and funding stage.
* **Top Layoffs by Year:** Determining the companies with the most layoffs for each year.
* **Rolling Total Layoffs:**  Calculating the cumulative sum of layoffs over time to visualize trends.

## Key Findings (Examples)

* ## Key Findings (Examples)
* **Biggest Layoffs:** Google (12,000), Meta (11,000), Microsoft (10,000), Amazon (10,000), and Ericsson (8,500) recorded the largest single layoff events.  
* **Most Affected Industries:** The Consumer (46,682 layoffs) and Retail (43,613 layoffs) sectors were the most impacted, followed by Other (36,289), Transportation (31,998), and Finance (28,344).  
* **Geographic Trends:** The United States was the hardest hit with 256,474 layoffs, far exceeding other countries like India (35,993), Netherlands (17,220), Sweden (11,264), and Brazil (10,691).  
* **Layoff Trends Over Time:** Layoffs peaked in 2022 with 161,711 recorded, followed by 127,277 in 2023. Earlier years saw fewer layoffs, with 81,068 in 2020 and 15,823 in 2021.  


## SQL Queries

The SQL queries used for data cleaning, standardization, and EDA are available in the [layoffs_analysis.sql](layoffs_analysis.sql) file. The queries are well-commented to explain the logic and purpose of each step.


## Data Visualization

While this README provides a summary of the analysis, data visualizations would further enhance the understanding of the findings. Future work could involve creating charts and graphs to illustrate the trends and patterns discovered. (You can add links to visualizations if you create them).


## How to Run the Analysis

1. **Dataset:** Download the Layoffs 2022 dataset from [Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-22).
2. **Database:**  Set up a database (e.g., MySQL, PostgreSQL) and import the dataset.
3. **SQL Script:** Execute the SQL queries in the [layoffs_analysis.sql](layoffs_analysis.sql) file against your database.

## Contributions

Contributions and suggestions for further analysis are welcome!

