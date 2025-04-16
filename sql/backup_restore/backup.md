### Backup Database

Buatlah 1 file backup berisi tabel `customers`, `customer_customer_demo`, dan `customer_demographics`.

- format umum
    ```sh
    pg_dump -U [user] -p [port] -d [nama_database] -t [nama_table] -f [file_output.sql]
    ```

- local database
    ```sh
    pg_dump -U postgres -p 5433 -d northwind -t customers -t customer_customer_demo -t customer_demographics -f backup_local.sql
    ```

- cloud database
    ```sh
    pg_dump "postgres://avnadmin:AVNS_DA54Uh3bRUja9f3tKnF@pemicu2-pemicu2.d.aivencloud.com:25264/defaultdb?sslmode=require" -t customers -t customer_customer_demo -t customer_demographics -f backup_cloud.sql
    ```