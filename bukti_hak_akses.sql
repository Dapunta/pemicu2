-- [ ADMIN ]
-- terminal : psql -U admin_northwind -d northwind -p 5433
-- password : adminnorthwind123

-- SELECT
SELECT COUNT(*) FROM employees;     -- berhasil
SELECT COUNT(*) FROM orders;        -- berhasil
SELECT COUNT(*) FROM order_details; -- gagal
SELECT COUNT(*) FROM suppliers;     -- gagal

-- INSERT
INSERT INTO employees (employee_id, first_name, last_name) VALUES (999, 'Test', 'Admin');
INSERT INTO orders (order_id, customer_id, employee_id) VALUES (999999, 'ALFKI', 1);

-- UPDATE
UPDATE employees SET first_name = 'UpdatedAdmin' WHERE employee_id = 999;
UPDATE orders SET employee_id = 2 WHERE order_id = 999999;

-- DELETE
DELETE FROM employees WHERE employee_id = 999;
DELETE FROM orders WHERE order_id = 999999;



-- [ SALES ]
-- terminal : psql -U sales_northwind -d northwind -p 5433
-- password : salesnorthwind123

-- SELECT
SELECT COUNT(*) FROM products;      -- berhasil
SELECT COUNT(*) FROM suppliers;     -- gagal
SELECT COUNT(*) FROM orders;        -- gagal



-- [ HR ]
-- terminal : psql -U hr_northwind -d northwind -p 5433
-- password : hrnorthwind123

-- SELECT
SELECT COUNT(*) FROM employees;     -- berhasil
SELECT COUNT(*) FROM orders;        -- gagal
SELECT COUNT(*) FROM order_details; -- gagal