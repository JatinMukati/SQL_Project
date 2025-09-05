# Vendor Performance & Retail Analytics – Inventory & Sales Insights  

Analyzing vendor performance, sales dynamics, and inventory to guide data-driven procurement, pricing, and promotional strategies using SQL, Python, and Power BI.  

---

## 📌 Table of Contents  
- [Introduction](#introduction)  
- [Problem Statement](#problem-statement)  
- [Dataset](#dataset)  
- [Tech Stack](#tech-stack)  
- [Folder Layout](#folder-layout)  
- [Data Preparation](#data-preparation)  
- [Exploratory Analysis](#exploratory-analysis)  
- [Insights & Findings](#insights--findings)  
- [Dashboard](#dashboard)  
- [Running the Project](#running-the-project)  
- [Recommendations](#recommendations)  
- [Contact](#contact)  

---

## Introduction  
This project investigates **vendor efficiency and inventory movement** in retail, supporting procurement decisions, profit optimization, and promotional planning.  
It combines **SQL** for data handling, **Python** for analysis, and **Power BI** for visualization.  

---

## Problem Statement  
In retail, managing vendors and inventory directly impacts profitability.  
The key questions addressed were:  
- Which vendors consistently underperform?  
- How much do vendors contribute to revenue and profit?  
- What are the cost structures and purchasing patterns?  
- Are there significant differences in vendor profitability?  

---

## Dataset  
- Raw data in CSV files (sales, vendors, inventory).  
- Summary tables prepared after data ingestion.  

---

## Tech Stack  
- **SQL** (Joins, CTEs, Window Functions)  
- **Python** (Pandas, Matplotlib, Seaborn)  
- **Power BI** (Dashboard & KPIs)  
- **GitHub** (Version control)  

---

## Folder Layout  
```
vendor-performance-analysis/
│── data/                # Raw CSV files
│── scripts/             # ETL and summary scripts
│── notebooks/           # Exploratory analysis
│── dashboards/          # Power BI dashboards
│── README.md            # Documentation
```

---

## Data Preparation  
- Filtered invalid rows (e.g., missing vendor IDs, gross profit ≤ 0).  
- Standardized date formats and numeric columns.  
- Created calculated fields for margin & profitability.  

---

## Exploratory Analysis  
- **Negative/Zero values:** flagged and excluded.  
- **Outliers:** extreme cost and purchase values detected.  
- **Correlations:** strong link between purchase cost and sales.  

---

## Insights & Findings  
1. **Promotions:** Top vendors with low sales but high margins suggest missed promotion opportunities.  
2. **Bulk Purchases:** Nearly 75% of orders are from bulk vendors.  
3. **Inventory:** ~17M worth of stock tied up in slow-moving items.  
4. **Profitability:** Vendor profit margins vary widely across categories.  
5. **Hypothesis Testing:** Clear statistical differences in vendor margins.  

---

## Dashboard  
Interactive **Power BI dashboard** with:  
- Vendor sales & margins  
- Inventory turnover  
- Bulk vs retail purchase comparison  
- Vendor profitability  

📊 Example:  
![Dashboard Preview](dashboard.png)  

---

## Running the Project  
1. Clone the repo:  
   ```bash
   git clone <your_repo_link>
   ```  

2. Load CSVs into the database:  
   ```bash
   python scripts/ingestion.py
   ```  

3. Generate vendor summary:  
   ```bash
   python scripts/vendor_summary.py
   ```  

4. Open notebooks for analysis:  
   ```bash
   jupyter notebook notebooks/vendor_analysis.ipynb
   ```  

5. View the Power BI dashboard in `/dashboards`.  

---

## Recommendations  
- Diversify vendor portfolio to reduce dependency.  
- Negotiate better pricing from low-margin vendors.  
- Clear non-moving inventory quickly.  
- Focus marketing spend on profitable vendors.  

---

## Contact  
👤 **Your Name**  
📧 Email: [your.email@example.com]  
🔗 [LinkedIn](#) | [Portfolio](#)  
