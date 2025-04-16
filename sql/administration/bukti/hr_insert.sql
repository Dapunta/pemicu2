-- hr hanya bisa INSERT ke table `employees`

-- bisa
INSERT INTO employees (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address, city, region, postal_code, country, home_phone, extension, photo, notes, reports_to, photo_path)
VALUES (11, 'Maharani', 'Suci', 'Ibu Negara', 'Prof.', '2002-03-27', '2012-03-27', 'Tambun', 'Bekasi', 'ID', '202020', 'ID', '082243211234', '1234', NULL, 'orang sibuk', '1', 'kosong');

-- tidak bisa
INSERT INTO orders (order_id, customer_id, employee_id)
VALUES (5000001, 'FOLKO', 1);

-- tidak bisa
INSERT INTO suppliers (supplier_id, company_name, city)
VALUES (32, 'APACONA', 'Surabaya');

