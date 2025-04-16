-- admin hanya bisa DELETE pada table `employees` dan `orders`
DELETE FROM employees WHERE employee_id = 10; -- bisa
DELETE FROM orders WHERE order_id = 5000000;  -- bisa
DELETE FROM suppliers WHERE supplier_id = 31; -- tidak bisa

