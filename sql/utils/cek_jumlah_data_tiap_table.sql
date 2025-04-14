SELECT 'suppliers' AS table_name, COUNT(*) AS jumlah_data FROM suppliers
UNION ALL
SELECT 'customers' AS table_name, COUNT(*) AS jumlah_data FROM customers
UNION ALL
SELECT 'employees' AS table_name, COUNT(*) AS jumlah_data FROM employees
UNION ALL
SELECT 'employee_territories' AS table_name, COUNT(*) AS jumlah_data FROM employee_territories
UNION ALL
SELECT 'territories' AS table_name, COUNT(*) AS jumlah_data FROM territories
UNION ALL
SELECT 'products' AS table_name, COUNT(*) AS jumlah_data FROM products
UNION ALL
SELECT 'region' AS table_name, COUNT(*) AS jumlah_data FROM region
UNION ALL
SELECT 'orders' AS table_name, COUNT(*) AS jumlah_data FROM orders
UNION ALL
SELECT 'us_states' AS table_name, COUNT(*) AS jumlah_data FROM us_states
UNION ALL
SELECT 'order_details' AS table_name, COUNT(*) AS jumlah_data FROM order_details
UNION ALL
SELECT 'shippers' AS table_name, COUNT(*) AS jumlah_data FROM shippers
UNION ALL
SELECT 'payments' AS table_name, COUNT(*) AS jumlah_data FROM payments
UNION ALL
SELECT 'categories' AS table_name, COUNT(*) AS jumlah_data FROM categories
UNION ALL
SELECT 'customer_demographics' AS table_name, COUNT(*) AS jumlah_data FROM customer_demographics
UNION ALL
SELECT 'customer_customer_demo' AS table_name, COUNT(*) AS jumlah_data FROM customer_customer_demo;