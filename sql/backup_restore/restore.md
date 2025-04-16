### Restore Database

1. buat database kosong
    - format umum
        ```sql
        psql -U [user] -p [port] -d [nama_database_awal] -c "CREATE DATABASE [nama_database_baru];"
        ```
    - local database
        ```sql
        psql -U postgres -p 5433 -d postgres -c "CREATE DATABASE northwind_new;"
        ```
    - cloud database
        ```sql
        psql "postgres://avnadmin:AVNS_DA54Uh3bRUja9f3tKnF@pemicu2-pemicu2.d.aivencloud.com:25264/defaultdb?sslmode=require" -c "CREATE DATABASE northwind_new;"
        ```

2. restore database
    - format umum
        ```sql
        psql -U [user] -p [port] -d [nama_database_baru] -f [file_backup.sql]
        ```
    - local database
        ```sql
        psql -U postgres -p 5433 -d northwind_new -f backup_local.sql
        ```
    - cloud database
        ```sql
        psql "postgres://avnadmin:AVNS_DA54Uh3bRUja9f3tKnF@pemicu2-pemicu2.d.aivencloud.com:25264/northwind_new?sslmode=require" -f backup_cloud.sql
        ```