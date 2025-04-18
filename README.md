# Pemicu 2

Query SQL untuk create table, relation, dan insert data  
Link : [Download Disini](https://drive.google.com/file/d/1g_OGEaDeOvwNqglYqdX8l87gs1VicFQ1/view)  
Kemudian letakkan dalam `sql/`  

PostgreSQL : [Download](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)  
pgAdmin 4 : [Windows](https://www.pgadmin.org/download/pgadmin-4-windows/)/[Linux](https://www.pgadmin.org/download/pgadmin-4-apt/)

<br>

# Pekerjaan 1 (indexing)

## Kondisi

- Kolom sering digunakan dalam klausa WHERE atau dalam kondisi join 
- Kolom berisi nilai dengan jangkauan yang luas 
- Kolom berisi banyak nilai null 
- Beberapa kolom sering digunakan dalam klausa WHERE atau dalam kondisi join 
- Tabel berukuran besar dan sebagian besar query menampilkan data kurang dari 2-4%

### Prosedur

- mencari kolom berisi nilai dengan jangkauan yang luas :
    - table orders : 900929 data
        ```sql
        SELECT COUNT(*) FROM orders;
        ```
    - table order_details : 4977189 data
        ```sql
        SELECT COUNT(*) FROM order_details;
        ```
- kolom berisi banyak nilai null :
    - kolom `ship_region` pada table `orders` *(ditemukan 592835 data bernilai NULL)*
        ```sql
        SELECT COUNT(o.ship_region)
        FROM orders o
        WHERE o.ship_region IS NULL
           OR o.ship_region ILIKE 'null'
           OR o.ship_region = '';
        ```

### Ketentuan Query

dari informasi diatas,  
ketentuan pembuatan query adalah :
- menggunakan table `orders` dan `order_details`, selain itu opsional *(usahakan ada)*
- menggunakan kolom `ship_region` pada table `orders` *(karena terdapat banyak nilai null)*
- menggunakan **WHERE** dan **JOIN**
- query harus menampilkan data kurang dari 2-4% dari seluruh data table, tidak boleh lebih.

### Contoh Query

- **contoh 1**
    - query select
        ```sql
        EXPLAIN ANALYZE
        SELECT 
            o.order_id,
            o.order_date,
            o.ship_region,
            c.company_name,
            d.product_id,
            d.unit_price,
            d.quantity,
            d.discount
        FROM orders o
        JOIN order_details d ON o.order_id = d.order_id
        JOIN customers c ON o.customer_id = c.customer_id
        WHERE 
            (o.ship_region IS NULL
             OR o.ship_region ILIKE 'null'
             OR o.ship_region = '')
          AND o.order_date BETWEEN '1996-01-01' AND '1998-01-01'
          AND d.unit_price > 100
          AND d.discount > 0.2
        ORDER BY o.order_date DESC;
        ```
    - query index
        ```sql
        CREATE INDEX IF NOT EXISTS idx_orders_ship_region ON orders(ship_region);
        CREATE INDEX IF NOT EXISTS idx_order_details_unit_price ON order_details(unit_price);
        CREATE INDEX IF NOT EXISTS idx_order_details_discount ON order_details(discount);
        CREATE INDEX IF NOT EXISTS idx_orders_order_id ON orders(order_id);
        CREATE INDEX IF NOT EXISTS idx_order_details_order_id ON order_details(order_id);
        CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
        CREATE INDEX IF NOT EXISTS idx_customers_customer_id ON customers(customer_id);
        CREATE INDEX IF NOT EXISTS idx_orders_order_date ON orders(order_date);
        ```
    - hasil analisis
        - [sebelum indexing](/image/indexing/indexing_1_sebelum.png)
        - [setelah indexing](/image/indexing/indexing_1_setelah.png)

        &nbsp;

        | **Parameter**            | **Sebelum Indexing**            | **Setelah Indexing**              |
        |--------------------------|----------------------------------|-----------------------------------|
        | Waktu eksekusi           | 181.518 ms                       | 31.579 ms                         |
        | Strategi scan            | Parallel Seq Scan               | Bitmap Index + Index Scan        |
        | Strategi join            | Parallel Hash Join              | Nested Loop Join                 |
        | Efisiensi filter         | Lambat (dengan full scan)       | Cepat (difilter oleh index)      |
        | Baris yang dieliminasi   | Jutaan                           | Ratusan                           |

- **contoh 2**
    - query select
        ```sql
        EXPLAIN ANALYZE
        SELECT 
            o.order_id,
            o.order_date,
            p.product_name,
            d.unit_price,
            d.quantity,
            d.unit_price * d.quantity AS total
        FROM orders o
        JOIN order_details d ON o.order_id = d.order_id
        JOIN products p ON d.product_id = p.product_id
        WHERE d.unit_price > 50
        ORDER BY total DESC
        LIMIT 50;
        ```
    - query index
        ```sql
        CREATE INDEX IF NOT EXISTS idx_order_details_unit_price ON order_details(unit_price);
        CREATE INDEX IF NOT EXISTS idx_order_details_product_id ON order_details(product_id);
        CREATE INDEX IF NOT EXISTS idx_order_details_order_id ON order_details(order_id);
        CREATE INDEX IF NOT EXISTS idx_products_product_id ON products(product_id);
        CREATE INDEX IF NOT EXISTS idx_orders_order_id ON orders(order_id);
        CREATE INDEX IF NOT EXISTS idx_order_details_total_expr ON order_details ((unit_price * quantity));
        ```
    - hasil analisis
        - [sebelum indexing](/image/indexing/indexing_2_sebelum.png)
        - [setelah indexing](/image/indexing/indexing_2_setelah.png)

        &nbsp;

        | **Parameter**            | **Sebelum Indexing**            | **Setelah Indexing**              |
        |--------------------------|----------------------------------|-----------------------------------|
        | Waktu eksekusi | 360.336 ms | 1.122 ms |
        | Join method | Parallel Hash Join (multi-threaded) | Nested Loop (lebih ringan, efisien dengan index) |
        | Sort method | Top-N Heapsort (dari hasil besar) | Tidak perlu sort eksplisit (pakai index scan) |
        | Filter | Dilakukan saat Seq Scan (brute force) | Dilakukan saat Index Scan |
        | Scan | Parallel Seq Scan on order_details, orders | Index Scan menggunakan idx_* |
        | Jumlah rows dibaca | 373.000+ | ~50 (langsung baca dari index) |
        | Functional index  | Tidak digunakan | idx_order_details_total_expr aktif |
        | Cache mode | Tidak disebutkan | Logical cache aktif (memoize, cache key) |

### Kesimpulan

- Dampak penggunaan indexing pada suatu database
    | Aspek | Dampak Indexing |
    |-------|-----------------|
    | Waktu eksekusi | Jauh lebih cepat |
    | Strategi scan | Index Scan > Seq Scan |
    | Join method | Nested Loop > Hash Join |
    | Filter | Langsung lewat index |
    | Baris yang dibaca | Turun drastis |
    | Resource server | Lebih hemat |

<br>

# Pekerjaan 2 (tuning database)

<br>

Sebelum tuning


Setelah Tuning

![image](https://github.com/user-attachments/assets/fc382805-86d2-4ddb-8c0d-4d2dcc16d921)

 Yang terjadi:
GROUP BY digunakan untuk mengelompokkan data unik, efeknya sama seperti DISTINCT dalam konteks ini.

Tidak ada ORDER BY, sehingga menghindari sort.

Query lebih ringan untuk query planner, lebih mudah dioptimasi.

Cocok dengan prinsip tuning: hindari sort, hindari DISTINCT, hindari ORDER BY.

📈 Keuntungan:
Eksekusi lebih cepat.

Ramah resource (tidak butuh banyak memori).

Cocok untuk data besar dan partial scanning (ingat: query hanya ambil sebagian kecil data).


Analisis

## Analisis Perbandingan Query Plan

| Aspek                  | Sebelum Tuning                                                                 | Setelah Tuning                                                          |
|-------------------------|--------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| **Jenis Join**          | Hash Join antara `orders` dan `customers`                                       | Nested Loop dengan Memoize untuk efisiensi lookup                      |
| **Scan**                | Sequential Scan (`Seq Scan`) di `orders` dan `customers`                      | Index Scan (`index_order_pk` di `orders`, `pk_customers` di `customers`) |
| **Sort**                | External Merge Sort (menggunakan disk 45872kB)                                 | Incremental Sort (menggunakan memory, lebih ringan)                    |
| **Penghapusan Duplikat**| DISTINCT + Unique operator (biaya tinggi)                                       | GROUP BY (lebih efisien untuk grup data)                                |
| **Resource**            | High I/O, High Disk Usage, Memory Pressure                                     | Lebih hemat memory dan disk usage                                       |
| **Planning Time**       | 0.252 ms                                                                       | 0.221 ms                                                               |
| **Execution Time**      | 2600.570 ms (~2.6 detik)                                                       | 751.308 ms (~0.75 detik)                                                |
| **Jumlah Rows**         | ~900.000 rows diproses                                                         | ~900.000 rows diproses (lebih cepat karena index & cache)              |
| **Optimisasi**          | Tidak optimal, heavy resource usage                                            | Optimal dengan index, memoize, dan sort lebih ringan                  |

## Ringkasan
- Query setelah tuning **3.5x lebih cepat** dari sebelumnya.
- Penggunaan **Index Scan**, **Memoize**, dan **Incremental Sort** sangat mengurangi beban sistem.
- **GROUP BY** lebih disukai daripada **DISTINCT** dalam kasus ini karena lebih predictable untuk PostgreSQL planner.
- Pemakaian **Memoize** efektif karena banyak lookup berulang ke `customers`.

## Saran Optimasi Tambahan
- Buat **Partial Index** di tabel `orders` untuk kolom `order_date` (`WHERE order_date >= '1997-01-01'`).
- Aktifkan **Parallel Execution** di PostgreSQL untuk query lebih besar.
- Pertimbangkan buat **Materialized View** kalau query sering dipanggil.

Kesimpulan

## Kesimpulan

| Aspek        | Sebelum Tuning | Setelah Tuning | Perbedaan |
|--------------|----------------|----------------|-----------|
| Eksekusi     | 2600 ms         | 751 ms          | ~3.5x lebih cepat |
| Join Type    | Hash Join       | Nested Loop + Memoize | Nested Loop lebih hemat untuk lookup kecil |
| Scan Type    | Seq Scan        | Index Scan      | Index Scan lebih targeted dan cepat |
| Sort         | External Merge Sort (pakai disk) | Incremental Sort (pakai memory) | Hemat resource, lebih cepat |
| Distinct     | DISTINCT + Unique | GROUP BY       | GROUP BY lebih efisien untuk eliminasi duplikat |

## Catatan
- Setelah tuning, query lebih optimal karena memanfaatkan index dan caching (`Memoize`).
- Execution Time berkurang drastis dari **2.6 detik** menjadi **0.75 detik**.
- Potensi optimasi tambahan: 
  - Buat partial index di `orders (order_date)` untuk kondisi `>= '1997-01-01'`
  - Pakai parallel query processing.
  - Materialized view jika query sering digunakan.


<br>

# Pekerjaan 3 (administrasi database)

<br>

1. user
    ```sql
    CREATE USER admin_northwind WITH PASSWORD 'adminnorthwind123';
    CREATE USER sales_northwind WITH PASSWORD 'salesnorthwind123';
    CREATE USER hr_northwind WITH PASSWORD 'hrnorthwind123';
    ```
    - [hasil](/image/administration/tambah_user_sebelum.png) sebelum menambahkan user
    - [hasil](/image/administration/tambah_user_setelah.png) setelah menambahkan user
2. hak akses
    ```sql
    -- admin_northwind
    GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO admin_northwind;
    GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO admin_northwind;

    -- sales_northwind
    GRANT SELECT ON products TO sales_northwind;
    GRANT INSERT, UPDATE ON suppliers TO sales_northwind;

    -- hr_northwind
    GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO hr_northwind;
    ```
    - [hasil](/image/administration/hak_akses_sebelum.png) sebelum menambahkan hak akses
    - [hasil](/image/administration/hak_akses_setelah.png) setelah menambahkan hak akses
3. bukti user dan penggunaan hak akses
    ```sql
    -- lihat semua daftar hak akses
    SELECT 
        grantee AS user_name,
        table_name,
        string_agg(privilege_type, ', ' ORDER BY privilege_type) AS privileges
    FROM information_schema.role_table_grants
    WHERE grantee IN ('admin_northwind', 'sales_northwind', 'hr_northwind')
    GROUP BY grantee, table_name
    ORDER BY grantee, table_name;
    ```
    - [hasil](/image/administration/bukti/)
4. memory management
    - [step](/sql/memory_management/setting.md)
    - [hasil](/image/memory_management/)
5. backup & restore
    - [step backup](/sql/backup_restore/backup.md)
    - [step restore](/sql/backup_restore/restore.md)
    - [hasil](/image/backup_restore/)

<br>
