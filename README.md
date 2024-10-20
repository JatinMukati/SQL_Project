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

* **Biggest Layoffs:**  [Mention the company with the largest single layoff event and the number of layoffs].
* **Most Affected Industries:**  [List the top 2-3 industries with the most layoffs].
* **Geographic Trends:** [Highlight any significant geographic trends observed in the data].
* **Layoff Trends Over Time:**  [Describe any noticeable trends in layoffs over the time period covered by the dataset].


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


## License

[Choose a license (e.g., MIT License)](LICENSE)
