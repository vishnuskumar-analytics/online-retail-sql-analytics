/*
Business Analysis
Purpose: Core revenue and customer analytics
*/

/* 1. Total Revenue */
SELECT SUM(quantity * price) AS total_revenue
FROM online_retail_clean;


/* 2. Revenue by Country */
SELECT
    country,
    SUM(quantity * price) AS revenue
FROM online_retail_clean
GROUP BY country
ORDER BY revenue DESC;


/* 3. Monthly Revenue Trend */
SELECT
    DATE_TRUNC('month', invoicedate) AS month,
    SUM(quantity * price) AS revenue
FROM online_retail_clean
GROUP BY month
ORDER BY month;


/* 4. Top 10 Products by Revenue (Exclude Operational Codes) */
SELECT
    stockcode,
    SUM(quantity * price) AS revenue
FROM online_retail_clean
WHERE stockcode NOT IN ('POST', 'M', 'DOT')
GROUP BY stockcode
ORDER BY revenue DESC
LIMIT 10;


/* 5. Top 10 Customers by Revenue */
SELECT
    customer_id,
    SUM(quantity * price) AS revenue
FROM online_retail_clean
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;


/* 6. RFM Base Table */

WITH max_date AS (
    SELECT MAX(invoicedate) AS max_dt
    FROM online_retail_clean
),

rfm AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice) AS frequency,
        SUM(quantity * price) AS monetary,
        DATE_PART(
            'day',
            (SELECT max_dt FROM max_date) - MAX(invoicedate)
        ) AS recency_days
    FROM online_retail_clean
    GROUP BY customer_id
)

SELECT *
FROM rfm
ORDER BY monetary DESC
LIMIT 10;


/* 7. Create RFM View */

CREATE OR REPLACE VIEW rfm_segmented AS

WITH max_date AS (
    SELECT MAX(invoicedate) AS max_dt
    FROM online_retail_clean
),

rfm AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice) AS frequency,
        SUM(quantity * price) AS monetary,
        DATE_PART(
            'day',
            (SELECT max_dt FROM max_date) - MAX(invoicedate)
        ) AS recency_days
    FROM online_retail_clean
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
),

rfm_scored AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY recency_days ASC)  AS r_raw,
        NTILE(5) OVER (ORDER BY frequency DESC)   AS f_score,
        NTILE(5) OVER (ORDER BY monetary DESC)    AS m_score
    FROM rfm
),

rfm_final AS (
    SELECT *,
        (6 - r_raw) AS r_score,
        ((6 - r_raw) + f_score + m_score) AS rfm_total_score
    FROM rfm_scored
)

SELECT *,
    CASE
    WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4
        THEN 'Champions'

    WHEN r_score >= 3 AND f_score >= 3
        THEN 'Loyal Customers'

    WHEN r_score >= 3
        THEN 'Potential Loyalists'

    WHEN r_score <= 2 AND f_score >= 3
        THEN 'At Risk'

    ELSE 'Lost'
END AS customer_segment
FROM rfm_final;


/* 8. Segment Revenue Contribution */

SELECT 
    customer_segment,
    COUNT(*) AS customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_customers,
    SUM(monetary) AS total_revenue,
    ROUND(100.0 * SUM(monetary) / SUM(SUM(monetary)) OVER (), 2) AS pct_revenue
FROM rfm_segmented
GROUP BY customer_segment
ORDER BY total_revenue DESC;