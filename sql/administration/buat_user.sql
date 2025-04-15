-- buat user : untuk user login biasa
CREATE USER admin_northwind WITH PASSWORD 'adminnorthwind123';
CREATE USER sales_northwind WITH PASSWORD 'salesnorthwind123';
CREATE USER hr_northwind WITH PASSWORD 'hrnorthwind123';

-- buat role : untuk role grup / manajemen hak akses
CREATE ROLE admin_northwind LOGIN PASSWORD 'adminnorthwind123';
CREATE ROLE sales_northwind LOGIN PASSWORD 'salesnorthwind123';
CREATE ROLE hr_northwind LOGIN PASSWORD 'hrnorthwind123';