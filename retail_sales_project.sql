-- Create database
CREATE DATABASE retail_sales;
USE retail_sales;

-- Create table
CREATE TABLE sales (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    region VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE
);

-- Insert data
INSERT INTO sales (customer_name, product_name, region, quantity, price, order_date) VALUES
('Ahmed','Phone','Cairo',2,12000,'2024-01-01'),
('Sara','Laptop','Cairo',1,15000,'2024-01-02'),
('Ali','Tablet','Alex',3,6000,'2024-01-03'),
('Mona','Phone','Giza',1,12000,'2024-01-04'),
('Hassan','Shoes','Alex',4,800,'2024-01-05'),
('Nour','T-shirt','Cairo',5,500,'2024-01-06'),
('Karim','Laptop','Giza',2,15000,'2024-01-07'),
('Laila','Phone','Alex',3,12000,'2024-01-08'),
('Omar','Tablet','Cairo',2,6000,'2024-01-09'),
('Salma','Shoes','Giza',2,800,'2024-01-10'),
('Yara','Phone','Cairo',1,12000,'2024-01-11'),
('Mahmoud','Laptop','Alex',1,15000,'2024-01-12'),
('Ahmed','Tablet','Giza',2,6000,'2024-01-13'),
('Sara','Phone','Alex',1,12000,'2024-01-14'),
('Ali','Laptop','Cairo',1,15000,'2024-01-15'),
('Mona','Shoes','Cairo',3,800,'2024-01-16'),
('Hassan','Phone','Giza',2,12000,'2024-01-17'),
('Nour','Tablet','Alex',1,6000,'2024-01-18'),
('Karim','T-shirt','Giza',6,500,'2024-01-19'),
('Laila','Laptop','Cairo',1,15000,'2024-01-20'),
('Omar','Phone','Alex',2,12000,'2024-01-21'),
('Salma','Tablet','Cairo',3,6000,'2024-01-22'),
('Yara','Shoes','Alex',2,800,'2024-01-23'),
('Mahmoud','Phone','Giza',1,12000,'2024-01-24'),
('Ahmed','Laptop','Alex',1,15000,'2024-01-25'),
('Sara','T-shirt','Cairo',4,500,'2024-01-26'),
('Ali','Phone','Giza',2,12000,'2024-01-27'),
('Mona','Tablet','Cairo',1,6000,'2024-01-28'),
('Hassan','Laptop','Cairo',1,15000,'2024-01-29'),
('Nour','Shoes','Giza',3,800,'2024-01-30'),
('Karim','Phone','Alex',1,12000,'2024-02-01'),
('Laila','Tablet','Giza',2,6000,'2024-02-02'),
('Omar','Laptop','Cairo',1,15000,'2024-02-03'),
('Salma','Phone','Alex',2,12000,'2024-02-04'),
('Yara','Tablet','Giza',1,6000,'2024-02-05'),
('Mahmoud','Shoes','Cairo',2,800,'2024-02-06'),
('Ahmed','Phone','Alex',3,12000,'2024-02-07'),
('Sara','Laptop','Giza',1,15000,'2024-02-08'),
('Ali','T-shirt','Cairo',5,500,'2024-02-09'),
('Mona','Phone','Cairo',2,12000,'2024-02-10');

-- Total revenue
SELECT SUM(quantity * price) AS total_revenue
FROM sales;

-- Revenue by region
SELECT region,
       SUM(quantity * price) AS region_revenue
FROM sales
GROUP BY region
ORDER BY region_revenue DESC;

-- Revenue by product
SELECT product_name,
       SUM(quantity * price) AS product_revenue
FROM sales
GROUP BY product_name
ORDER BY product_revenue DESC;

-- Top customers
SELECT customer_name,
       SUM(quantity * price) AS customer_revenue
FROM sales
GROUP BY customer_name
ORDER BY customer_revenue DESC;

-- Average order value
SELECT SUM(quantity * price) / COUNT(*) AS aov
FROM sales;

-- Top product in each region
SELECT region,
       product_name,
       performance
FROM (
        SELECT region,
               product_name,
               SUM(quantity * price) AS performance,
               ROW_NUMBER() OVER (
                   PARTITION BY region
                   ORDER BY SUM(quantity * price) DESC
               ) AS rn
        FROM sales
        GROUP BY region, product_name
     ) AS ranked
WHERE rn = 1;
