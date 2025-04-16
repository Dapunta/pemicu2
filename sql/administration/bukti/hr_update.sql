-- hr hanya bisa UPDATE pada table `employees`
UPDATE employees SET city = 'Pacitan' WHERE employee_id = 1;        -- bisa
UPDATE orders SET ship_city = 'Semarang' WHERE order_id = 10248;    -- tidak bisa
UPDATE suppliers SET contact_title = 'Sepuh' WHERE supplier_id = 1; -- tidak bisa

