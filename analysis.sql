-- Total spending per customer
SELECT c.name, SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name;

-- City-wise revenue
SELECT c.city, SUM(p.price * o.quantity) AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.city;

-- Top selling product by quantity
SELECT p.product_name, SUM(o.quantity) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;

-- Customers who never ordered
SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 2nd highest spending customer
SELECT name, total_spent
FROM (
  SELECT c.name, SUM(p.price * o.quantity) AS total_spent
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id
  JOIN products p ON o.product_id = p.product_id
  GROUP BY c.name
) t
ORDER BY total_spent DESC
LIMIT 1 OFFSET 1;

-- Rank customers by spending
SELECT name, total_spent,
RANK() OVER (ORDER BY total_spent DESC) AS rank_pos
FROM (
  SELECT c.name, SUM(p.price * o.quantity) AS total_spent
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id
  JOIN products p ON o.product_id = p.product_id
  GROUP BY c.name
) t;
