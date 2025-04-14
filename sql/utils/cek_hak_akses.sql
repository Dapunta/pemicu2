SELECT 
    grantee AS user,
    table_schema,
    table_name,
    privilege_type
FROM 
    information_schema.role_table_grants
WHERE 
    grantee IN ('sales_northwind', 'admin_northwind', 'hr_northwind')
ORDER BY 
    grantee, table_schema, table_name, privilege_type;