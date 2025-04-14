# pindah ke direktori tugas
cd "C:\Users\ASUS ZENBOOK\Documents\DapuntaXD\All About ITS\Semester 4\Manajemen Basis Data\pemicu2\sql"

# membuat database
createdb -U [user] -p [port] [nama_database]
createdb -U postgres -p 5433 northwind

# hapus database
dropdb -U [user] -p [port] [nama_database]
dropdb -U postgres -p 5433 northwind

# execute file sql (INSERT, UPDATE, DELETE, dll) ke database
psql -U [user] -d [nama_database] -p [port] -f [path_nama_file_sql]
psql -U postgres -d northwind -p 5433 -f "C:\Users\Dapunta\Documents\northwind.sql"
# note : kalau terminal di-run dalam 1 direktori dengan file, gausa pake tanda petik

# koneksikan/masuk ke dalam database
psql -U [user] -p [port] [nama_database]
psql -U postgres -p 5433 northwind

# backup tabel ke file
pg_dump -U [user] -d [database] -p [port] -t [nama_tabel] > [nama_file_backup.sql]
pg_dump -U postgres -d northwind -p 5433 -t customers -t customer_customer_demo -t customer_demographics > backup_customers.sql

# restore file SQL ke database baru
# buat database baru terlebih dahulu
createdb -U [user] -p [port] [nama_database_baru]
createdb -U postgres -p 5433 northwind_restore
# restore file ke database baru
psql -U [user] -d [nama_database_baru] -p [port] -f [nama_file_backup.sql]
psql -U postgres -d northwind_restore -p 5433 -f backup_customers.sql

# restore
pg_restore -U [user] -d [nama_database_baru] -p [port] [nama_file.dump]
pg_restore -U postgres -d northwind_restore -p 5433 "backup_customers.dump"

# syntax dalam shell psql
\dt           # melihat semua tabel
\du           # melihat daftar user/role
\z            # melihat hak akses semua tabel
\z nama_tabel # melihat hak akses tabel (nama_tabel)