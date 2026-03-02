/*
Project: Online Retail SQL Analytics
Author: Vishnu S Kumar
Database: PostgreSQL
Description: Initial project validation and row count checks
*/

-- Confirm database
SELECT current_database();

-- Check raw table row count
SELECT COUNT(*) AS raw_row_count
FROM online_retail_raw;

-- Check clean table row count
SELECT COUNT(*) AS clean_row_count
FROM online_retail_clean;