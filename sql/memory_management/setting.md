### Memory Management

1. query untuk melihat config
    ```sql
    SELECT 'shared_buffers' AS parameter, current_setting('shared_buffers') AS value
    UNION ALL
    SELECT 'work_mem', current_setting('work_mem')
    UNION ALL
    SELECT 'maintenance_work_mem', current_setting('maintenance_work_mem')
    UNION ALL
    SELECT 'effective_cache_size', current_setting('effective_cache_size');
    ```

2. konfigurasi *(opsi 1 : manual)*  
    edit file `postgresql.conf` *(lokasi tergantung OS, misal: C:\Program Files\PostgreSQL\17\data\postgresql.conf)*  
    - lama :
        ```sql
        shared_buffers = 128MB
        work_mem = 4MB
        maintenance_work_mem = 64MB
        effective_cache_size = 4GB
        ```
    - baru :
        ```sql
        shared_buffers = 256MB
        work_mem = 32MB
        maintenance_work_mem = 512MB
        effective_cache_size = 6GB
        ```

3. konfigurasi *(opsi 2 : dengan query sql)*  
    - lama :
        ```sql
        ALTER SYSTEM SET shared_buffers = '128MB';
        ALTER SYSTEM SET work_mem = '4MB';
        ALTER SYSTEM SET maintenance_work_mem = '64MB';
        ALTER SYSTEM SET effective_cache_size = '4GB';
        ```
    - baru :
        ```sql
        ALTER SYSTEM SET shared_buffers = '256MB';
        ALTER SYSTEM SET work_mem = '32MB';
        ALTER SYSTEM SET maintenance_work_mem = '512MB';
        ALTER SYSTEM SET effective_cache_size = '6GB';
        ```

4. restart PostgreSQL  
    - windows
        ```sh
        pg_ctl restart -D "C:\Program Files\PostgreSQL\17\data"
        ```
    - linux
        ```sh
        sudo systemctl restart postgresql
        ```

5. hasil
    - [konfigurasi sebelum](/image/memory_management/memory_konfigurasi_sebelum.png)
    - [konfigurasi setelah](/image/memory_management/memory_konfigurasi_setelah.png)
    - [hasil sebelum](/image/memory_management/memory_result_sebelum.png)
    - [hasil setelah](/image/memory_management/memory_result_setelah.png)
    - hasil analisis
        | **Parameter**            | **Sebelum Tuning**            | **Setelah Tuning**              |
        |--------------------------|----------------------------------|-----------------------------------|
        | shared_buffers | 128MB | 256MB |
        | work_mem | 4MB | 32MB |
        | maintenance_work_mem | 64MB | 512MB |
        | effective_cache_size | 4GB | 6GB |
        | Sort Method | top-N heapsort (33kB mem) | top-N heapsort (32kB mem) |
        | Planning Time | 2.064 ms | 4.067 ms |
        | Execution Time | 369.420 ms | 280.608 ms |