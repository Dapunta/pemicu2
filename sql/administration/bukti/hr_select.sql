-- hr hanya bisa SELECT pada table `employees`
SELECT COUNT(*) FROM employees;     -- bisa
SELECT COUNT(*) FROM orders;        -- tidak bisa
SELECT COUNT(*) FROM order_details; -- tidak bisa

