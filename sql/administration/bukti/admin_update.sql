-- admin hanya bisa UPDATE pada table `employees` dan `orders`
UPDATE employees SET city = 'Yogyakarta' WHERE employee_id = 1;     -- bisa
UPDATE orders SET ship_city = 'Surabaya' WHERE order_id = 10248;    -- bisa
UPDATE suppliers SET contact_title = 'Sepuh' WHERE supplier_id = 1; -- tidak bisa

