-- hr hanya bisa DELETE pada table `employees`
DELETE FROM employees WHERE employee_id = 11; -- bisa
DELETE FROM orders WHERE order_id = 5000001;  -- tidak bisa
DELETE FROM suppliers WHERE supplier_id = 32; -- tidak bisa

