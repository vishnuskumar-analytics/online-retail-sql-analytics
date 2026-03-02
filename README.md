<<<<<<< HEAD
# online-retail-sql-analytics
PostgreSQL project analyzing online retail transactional data with KPIs and RFM customer segmentation.
=======
# Online Retail SQL Analytics (PostgreSQL)

## Overview
This project analyzes an online retail transactions dataset using PostgreSQL.
It includes a clean data layer, quality checks, core revenue KPIs, and RFM-based customer segmentation.

## Tech Stack
- PostgreSQL
- psql (CLI)
- SQL (CTEs, window functions, views)

## Dataset
Online retail transactional data with fields like:
invoice, stockcode, description, quantity, invoicedate, price, customer_id, country

> Note: The raw dataset file is not included in this repo.

## Project Structure
- sql/00_project_setup.sql — database validation + row counts
- sql/01_data_quality_checks.sql — null checks, negative checks, date ranges
- sql/02_build_clean_table.sql — creates online_retail_clean
- sql/03_business_analysis.sql — KPIs + RFM segmentation + segment contribution

## Cleaning Logic (Clean Layer)
Created online_retail_clean by keeping only:
- customer_id IS NOT NULL
- quantity > 0
- price > 0

This removes anonymous customers, returns, and invalid pricing.

## Key Analyses
### Revenue KPIs
- Total revenue
- Revenue by country
- Monthly revenue trend
- Top products by revenue (excluding operational codes)
- Top customers by revenue

### RFM Segmentation
Built rfm_segmented view with:
- Recency (days since last purchase)
- Frequency (# distinct invoices)
- Monetary (total spend)

Scoring:
- quintiles using NTILE(5)
- total score = r_score + f_score + m_score

Segments:
- Champions (>=14)
- Loyal Customers (>=12)
- Potential Loyalists (>=10)
- At Risk (>=7)
- Lost (else)

## How to Run
1) Start psql and connect to your DB:
```sql
psql -d purpose -U pg4e
>>>>>>> bd03da0 (Initial commit)
