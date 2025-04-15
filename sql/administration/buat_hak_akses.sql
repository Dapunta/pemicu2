-- beri semua akses semua user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_northwind;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sales_northwind;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO hr_northwind;

-- admin_northwind
GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO admin_northwind;
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO admin_northwind;

-- sales_northwind
GRANT SELECT ON products TO sales_northwind;
GRANT INSERT, UPDATE ON suppliers TO sales_northwind;

-- hr_northwind
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO hr_northwind;