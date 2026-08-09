-- E-Commerce Sales & Customer Analytics
-- SQL Analysis

CREATE DATABASE ecommerce_analysis;

USE ecommerce_analysis;

-- View the data
SELECT * FROM ecommerce_sales_34500;

-- Total number of records
SELECT COUNT(*) FROM ecommerce_sales_34500;

-- View first 10 records
SELECT * FROM ecommerce_sales_34500
LIMIT 10;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_sales_34500;

-- Total Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM ecommerce_sales_34500;

-- Average Order Value
SELECT ROUND(AVG(total_amount), 2) AS average_order_value
FROM ecommerce_sales_34500;

-- Monthly Revenue and Orders
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(total_amount), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders
FROM ecommerce_sales_34500
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Category Performance
SELECT
    category,
    ROUND(SUM(total_amount), 2) AS revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT order_id) AS orders
FROM ecommerce_sales_34500
GROUP BY category
ORDER BY revenue DESC;

-- Regional Performance
SELECT
    region,
    ROUND(SUM(total_amount), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM ecommerce_sales_34500
GROUP BY region
ORDER BY revenue DESC;

-- Return Analysis
SELECT
    returned,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM ecommerce_sales_34500), 2
    ) AS percentage
FROM ecommerce_sales_34500
GROUP BY returned;

-- Payment Method Analysis
SELECT
    payment_method,
    COUNT(*) AS orders,
    ROUND(SUM(total_amount), 2) AS revenue
FROM ecommerce_sales_34500
GROUP BY payment_method
ORDER BY orders DESC;

-- Customer Gender Analysis
SELECT
    customer_gender,
    COUNT(*) AS orders,
    ROUND(SUM(total_amount), 2) AS revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM ecommerce_sales_34500
GROUP BY customer_gender
ORDER BY revenue DESC;

-- Customer Age Group Analysis
SELECT
    CASE
        WHEN customer_age < 25 THEN 'Under 25'
        WHEN customer_age BETWEEN 25 AND 34 THEN '25-34'
        WHEN customer_age BETWEEN 35 AND 44 THEN '35-44'
        WHEN customer_age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS orders,
    ROUND(SUM(total_amount), 2) AS revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM ecommerce_sales_34500
GROUP BY age_group
ORDER BY revenue DESC;

-- Discount Analysis
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount > 0 AND discount <= 0.10 THEN '0-10%'
        WHEN discount > 0.10 AND discount <= 0.20 THEN '10-20%'
        WHEN discount > 0.20 AND discount <= 0.30 THEN '20-30%'
        ELSE '30%+'
    END AS discount_group,
    COUNT(*) AS orders,
    ROUND(SUM(total_amount), 2) AS revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM ecommerce_sales_34500
GROUP BY discount_group
ORDER BY revenue DESC;