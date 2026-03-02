/*
Clean Table Creation
Purpose: Build analysis-ready dataset by removing invalid records
*/

-- Drop table if it already exists
DROP VIEW IF EXISTS online_retail_clean;
DROP TABLE IF EXISTS online_retail_clean;

-- Create cleaned table
CREATE TABLE online_retail_clean AS
SELECT *
FROM online_retail_raw
WHERE 
    customer_id IS NOT NULL        -- Remove anonymous customers
    AND quantity > 0               -- Remove returns (negative qty)
    AND price > 0;                 -- Remove negative or zero price