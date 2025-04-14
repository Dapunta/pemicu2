# pindah ke direktori tugas
cd "C:\Users\ASUS ZENBOOK\Documents\DapuntaXD\All About ITS\Semester 4\Manajemen Basis Data\pemicu2\sql"

# membuat database "northwind"
# syntax
createdb -U [user] -p [port] [nama_database]
# contoh
createdb -U postgres -p 5433 northwind

# execute file sql (INSERT, UPDATE, DELETE, dll) ke database
# syntax
psql -U [user] -d [nama_database] -p [port] -f [path_nama_file_sql]
# contoh
psql -U postgres -d northwind -p 5433 -f "C:\Users\Dapunta\Documents\northwind.sql"
# note
# kalau terminal di-run dalam 1 direktori dengan file, gausa pake tanda petik

# koneksikan/masuk ke dalam database
# syntax
psql -U [user] -p [port] [nama_database]
# contoh
psql -U postgres -p 5433 northwind

# syntax dalam shell psql
\dt           # melihat semua tabel
\du           # melihat daftar user/role
\z            # melihat hak akses semua tabel
\z nama_tabel # melihat hak akses tabel (nama_tabel)

# backup tabel ke file
# syntax
pg_dump -U [user] -d [database] -p [port] -t [nama_tabel] > nama_file.sql
# contoh backup 3 tabel
pg_dump -U postgres -d northwind -p 5433 -t customers -t customer_customer_demo -t customer_demographics > backup_customers.sql

# restore file SQL ke database baru
# buat database baru terlebih dahulu
createdb -U postgres -p 5433 northwind_restore
# restore file ke database baru
psql -U postgres -d northwind_restore -p 5433 -f backup_customers.sql