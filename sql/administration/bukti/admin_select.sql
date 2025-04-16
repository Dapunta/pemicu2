-- admin hanya bisa SELECT pada table `employees` dan `orders`
SELECT COUNT(*) FROM employees;     -- bisa
SELECT COUNT(*) FROM orders;        -- bisa
SELECT COUNT(*) FROM order_details; -- tidak bisa
SELECT COUNT(*) FROM suppliers;     -- tidak bisa

