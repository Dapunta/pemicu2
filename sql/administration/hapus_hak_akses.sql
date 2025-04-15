-- hapus semua akses semua user
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM admin_northwind;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM sales_northwind;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM hr_northwind;

-- admin_northwind
REVOKE SELECT, INSERT, UPDATE, DELETE ON orders FROM admin_northwind;
REVOKE SELECT, INSERT, UPDATE, DELETE ON employees FROM admin_northwind;

-- sales_northwind
REVOKE SELECT ON products FROM sales_northwind;
REVOKE INSERT, UPDATE ON suppliers FROM sales_northwind;

-- hr_northwind
REVOKE SELECT, INSERT, UPDATE, DELETE ON employees FROM hr_northwind;