/*
Data Quality Checks
Purpose: Identify null values, negative values, and date range issues
*/

-- 1. Total Row Count
SELECT COUNT(*) AS total_rows
FROM online_retail_raw;

-- 2. Date Range
SELECT 
    MIN(invoicedate) AS min_date,
    MAX(invoicedate) AS max_date
FROM online_retail_raw;

-- 3. Null Value Check
SELECT
    SUM(CASE WHEN invoice IS NULL THEN 1 ELSE 0 END) AS null_invoice,
    SUM(CASE WHEN stockcode IS NULL THEN 1 ELSE 0 END) AS null_stockcode,
    SUM(CASE WHEN invoicedate IS NULL THEN 1 ELSE 0 END) AS null_invoicedate,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id
FROM online_retail_raw;

-- 4. Negative and Zero Checks
SELECT
    SUM(CASE WHEN quantity < 0 THEN 1 ELSE 0 END) AS negative_quantity_rows,
    SUM(CASE WHEN price < 0 THEN 1 ELSE 0 END) AS negative_price_rows,
    SUM(CASE WHEN quantity = 0 THEN 1 ELSE 0 END) AS zero_quantity_rows
FROM online_retail_raw;