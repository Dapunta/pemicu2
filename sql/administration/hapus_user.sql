-- hapus user
DROP USER IF EXISTS admin_northwind;
DROP USER IF EXISTS sales_northwind;
DROP USER IF EXISTS hr_northwind;

-- hapus role
DROP ROLE IF EXISTS admin_northwind;
DROP ROLE IF EXISTS sales_northwind;
DROP ROLE IF EXISTS hr_northwind;

-- Revoke privileges pada semua objek
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM admin_northwind, sales_northwind, hr_northwind;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM admin_northwind, sales_northwind, hr_northwind;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM admin_northwind, sales_northwind, hr_northwind;

-- Revoke privileges pada schema itu sendiri (INI PENTING)
REVOKE ALL ON SCHEMA public FROM admin_northwind;
REVOKE ALL ON SCHEMA public FROM sales_northwind;
REVOKE ALL ON SCHEMA public FROM hr_northwind;

-- Revoke default privileges (optional tapi aman)
ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON TABLES FROM admin_northwind, sales_northwind, hr_northwind;

-- Ubah ownership semua tabel yang dimiliki user ke postgres
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN 
        SELECT tablename 
        FROM pg_tables 
        WHERE tableowner IN ('admin_northwind', 'sales_northwind', 'hr_northwind')
    LOOP
        EXECUTE format('ALTER TABLE public.%I OWNER TO postgres;', r.tablename);
    END LOOP;
END $$;

-- Drop user/role
DROP ROLE IF EXISTS admin_northwind;
DROP ROLE IF EXISTS sales_northwind;
DROP ROLE IF EXISTS hr_northwind;