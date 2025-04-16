-- sales hanya bisa INSERT ke table `suppliers`

-- bisa
INSERT INTO suppliers (supplier_id, company_name, city)
VALUES (30, 'XNSCODE', 'Yogyakarta');

-- tidak bisa
INSERT INTO employees (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address, city, region, postal_code, country, home_phone, extension, photo, notes, reports_to, photo_path)
VALUES (12, 'Rayartha', 'Hanastha', 'Putra Mahkota', 'Prof.', '2025-01-01', '2025-01-01', 'Sukolilo', 'Surabaya', 'ID', '303030', 'ID', '082211112222', '1234', NULL, 'orang sibuk', '1', 'kosong');

-- tidak bisa
INSERT INTO orders (order_id, customer_id, employee_id)
VALUES (5000002, 'ROMEY', 3);

