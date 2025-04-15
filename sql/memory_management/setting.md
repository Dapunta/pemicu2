[ STEP ]

1. lihat setting awal *(query sql)*  
    ```sql
    SHOW shared_buffers;
    SHOW work_mem;
    SHOW maintenance_work_mem;
    ```
    screenshot

2. konfigurasi  
    edit file `postgresql.conf` *(lokasi tergantung OS, misal: C:\Program Files\PostgreSQL\17\data\postgresql.conf)*
    ```c
    shared_buffers = 256MB
    work_mem = 4MB
    maintenance_work_mem = 64MB
    ```

3. restart PostgreSQL  
    jalankan di terminal
    ```sh
    pg_ctl restart -D "C:\Program Files\PostgreSQL\17\data"
    ```

4. lihat ulang setting *(query sql)*  
    ```sql
    SHOW shared_buffers;
    SHOW work_mem;
    SHOW maintenance_work_mem;
    ```
    screenshot