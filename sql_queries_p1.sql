-- SQL Retail Sales Analysis -p1
CREATE DATABASE Sql_Project_P1;
USE Sql_Project_P1;

CREATE TABLE Retail_Sales (
transactions_id INT PRIMARY KEY, 
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(10),
age	INT,
category VARCHAR(15),
quantiy	INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

-- Q.1
SELECT * FROM Retail_Sales;
SELECT count(*) FROM Retail_Sales;
SELECT COUNT(DISTINCT customer_id) FROM Retail_Sales;
SELECT DISTINCT category FROM Retail_Sales;

-- Q.2
SELECT * FROM Retail_Sales 
WHERE 
transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR
customer_id IS NULL OR gender IS NULL OR age IS NULL OR 
category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR
cogs IS NULL OR total_sale IS NULL;

DELETE FROM Retail_sales
WHERE 
transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR
customer_id IS NULL OR gender IS NULL OR age IS NULL OR 
category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR
cogs IS NULL OR total_sale IS NULL;

-- Q.2.1
ALTER TABLE Retail_sales RENAME COLUMN quantiy to quantity;

-- Q.3
SELECT * FROM Retail_sales 
WHERE sale_date ='2023-1-25';

-- Q.4
SELECT * FROM Retail_sales 
WHERE category ='clothing'AND 
quantity >= 3 AND 
YEAR(sale_date)=2023 AND
MONTH(sale_date) =05;

-- Q.5
SELECT category , 
SUM(total_sale) as net_sale,
COUNT(*) AS Total_Orders
FROM Retail_sales GROUP BY category;

-- Q.6
SELECT ROUND(AVG(age) , 2) AS Avg_age ,category
FROM Retail_sales 
WHERE category ='Electronics';

-- Q.7
SELECT * FROM Retail_sales 
WHERE total_sale>1500;

-- Q.8
SELECT category, 
COUNT(*) AS Total_transactions,
gender AS Gender 
FROM Retail_sales 
GROUP BY category,Gender
ORDER BY 1;

-- Q.9
SELECT 
YEAR(sale_date) year, 
MONTH(sale_date) month, 
ROUND(AVG(total_sale),3) avg_sales
FROM Retail_sales GROUP BY 1,2
 ORDER BY year DESC;

-- Q.10
SELECT year,month,avg_sales
FROM(
SELECT
YEAR(sale_date) year,
MONTH(sale_date) month,
AVG(total_sale) avg_sales,
RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) desc) as year_rank
FROM Retail_sales
GROUP BY 1,2) t1 
WHERE year_rank=1;

-- Q.11
SELECT customer_id ,SUM(total_sale) AS Total_sales
FROM Retail_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Q.12
SELECT DISTINCT(customer_id) , category
FROM Retail_sales
WHERE category IN('Beauty','Clothing','Electronics')
ORDER BY Customer_id;

-- Q.13
SELECT 
COUNT(DISTINCT customer_id) count_unq_customer,
category 
FROM Retail_sales
GROUP BY category;

-- Q.14

  SELECT 
  CASE 
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END as shift,
COUNT(*) AS Total_No_Orders
FROM Retail_sales
GROUP BY shift
ORDER BY shift desc;



