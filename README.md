# Online Retail Revenue & Customer Segmentation Analysis (PostgreSQL)

A business-focused PostgreSQL analytics project analyzing online retail transactional data to derive revenue KPIs and customer segmentation insights using RFM modeling.

---

## 🎯 Business Objective

This project simulates an analytics workflow for an e-commerce company.

Goals:
- Measure core revenue KPIs
- Identify high-value customers
- Detect churn risk segments
- Understand revenue contribution by customer segment

The project demonstrates how raw transactional data can be transformed into actionable business insights using SQL.

---

## 🏗 Project Workflow

The analysis follows a structured analytics pipeline:

1. *Data Validation*
2. *Data Cleaning (Analytical Layer Creation)*
3. *KPI Computation*
4. *Customer Segmentation (RFM)*
5. *Segment Revenue Contribution Analysis*

---

## 🛠 Tech Stack

- PostgreSQL
- psql (CLI)
- SQL
  - CTEs
  - Window Functions (NTILE)
  - Aggregations
  - Views
  - CASE logic

---

## 📊 Dataset

Online retail transactional dataset with fields such as:

- Invoice
- StockCode
- Description
- Quantity
- InvoiceDate
- Price
- Customer_ID
- Country

> Note: The raw dataset file is intentionally excluded from this repository.

---

## 🧹 Data Cleaning Strategy

A clean analytical table (online_retail_clean) is built using strict validation rules:

- customer_id IS NOT NULL
- quantity > 0
- price > 0

This removes:
- Anonymous transactions
- Returns
- Invalid pricing entries

This ensures that KPIs and segmentation are based only on valid commercial transactions.

---

## 📈 Revenue KPIs Computed

- Total Revenue
- Revenue by Country
- Monthly Revenue Trend
- Top Products by Revenue
- Top Customers by Revenue
- Segment Revenue Contribution

These KPIs simulate what a business dashboard would require for decision-making.

---

## 🧠 RFM Customer Segmentation

RFM metrics are calculated per customer:

- *Recency* → Days since last purchase  
- *Frequency* → Number of distinct invoices  
- *Monetary* → Total customer spend  

Scoring Method:
- Quintile scoring using NTILE(5)
- Recency score inverted using (6 - r_raw) so higher score = more recent
- Composite logic applied using behavioral conditions

---

### 🏷 Segment Definitions

Segments are assigned using rule-based conditions:

- *Champions*  
  r_score >= 4 AND f_score >= 4 AND m_score >= 4

- *Loyal Customers*  
  r_score >= 3 AND f_score >= 3

- *Potential Loyalists*  
  r_score >= 3

- *At Risk*  
  r_score <= 2 AND f_score >= 3

- *Lost*  
  All remaining customers

This prioritizes recency while incorporating purchasing intensity and value.

---

## 📂 Project Structure

- sql/00_project_setup.sql → Validation & record counts  
- sql/01_data_quality_checks.sql → Null & anomaly checks  
- sql/02_build_clean_table.sql → Clean analytical table  
- sql/03_business_analysis.sql → KPI analysis & RFM segmentation  

---

## 🚀 How to Run

Connect to PostgreSQL:

```bash
psql -d <database_name> -U <username>