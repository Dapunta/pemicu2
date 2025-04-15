-- lihat semua daftar user
SELECT rolname AS username
FROM pg_roles
WHERE rolcanlogin = true
ORDER BY rolname;

-- lihat semua daftar hak akses
SELECT 
    grantee AS user_name,
    table_name,
    string_agg(privilege_type, ', ' ORDER BY privilege_type) AS privileges
FROM information_schema.role_table_grants
WHERE grantee IN ('admin_northwind', 'sales_northwind', 'hr_northwind')
GROUP BY grantee, table_name
ORDER BY grantee, table_name;