-- sales hanya bisa UPDATE pada table `suppliers`
UPDATE suppliers SET company_name = 'APAAJAAPA' WHERE supplier_id = 1; -- bisa
UPDATE employees SET city = 'Bekasi' WHERE employee_id = 1;            -- tidak bisa
UPDATE orders SET ship_city = 'Pacitan' WHERE order_id = 10248;        -- tidak bisa

