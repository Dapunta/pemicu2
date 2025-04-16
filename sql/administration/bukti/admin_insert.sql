-- admin hanya bisa INSERT ke table `employees` dan `orders`

-- bisa
INSERT INTO employees (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address, city, region, postal_code, country, home_phone, extension, photo, notes, reports_to, photo_path)
VALUES (10, 'Ratya', 'Dapunta', 'Bos Besar', 'Prof.', '2005-05-02', '2015-05-02', 'Sleman', 'Yogyakarta', 'ID', '101010', 'ID', '082212344321', '1234', NULL, 'orang sibuk', '1', 'kosong');

-- bisa
INSERT INTO orders (order_id, customer_id, employee_id)
VALUES (5000000, 'HANAR', 5);

-- tidak bisa
INSERT INTO suppliers (supplier_id, company_name, city)
VALUES (31, 'APACOBA', 'Jakarta');

